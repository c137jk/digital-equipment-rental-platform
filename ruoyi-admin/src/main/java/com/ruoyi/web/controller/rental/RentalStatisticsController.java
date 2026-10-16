package com.ruoyi.web.controller.rental;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.rental.service.IRentalEquipmentService;
import com.ruoyi.rental.service.IRentalOrderService;

//数据统计Controller

@RestController
@RequestMapping("/rental/statistics")
public class RentalStatisticsController extends BaseController {
        @Autowired
        private IRentalEquipmentService equipmentService;

        @Autowired
        private IRentalOrderService orderService;

        /**
         * 获取统计数据
         */
        @GetMapping("/overview")
        public AjaxResult getOverview() {
                Map<String, Object> data = new HashMap<>();

                // 设备统计 - 从数据库查询
                Map<String, Object> equipmentStats = new HashMap<>();
                com.ruoyi.rental.domain.RentalEquipment equipmentQuery = new com.ruoyi.rental.domain.RentalEquipment();
                equipmentQuery.setDelFlag("0"); // 未删除的设备
                java.util.List<com.ruoyi.rental.domain.RentalEquipment> allEquipment = equipmentService
                                .selectRentalEquipmentList(equipmentQuery);

                int totalEquipment = allEquipment.size();
                int availableEquipment = (int) allEquipment.stream()
                                .filter(e -> "0".equals(e.getStatus()) && e.getStock() > 0)
                                .count();
                int rentedEquipment = (int) allEquipment.stream()
                                .filter(e -> e.getRentedCount() != null && e.getRentedCount() > 0).count();

                equipmentStats.put("total", totalEquipment);
                equipmentStats.put("available", availableEquipment);
                equipmentStats.put("rented", rentedEquipment);
                data.put("equipment", equipmentStats);

                // 订单统计 - 从数据库查询
                Map<String, Object> orderStats = new HashMap<>();
                com.ruoyi.rental.domain.RentalOrder orderQuery = new com.ruoyi.rental.domain.RentalOrder();
                java.util.List<com.ruoyi.rental.domain.RentalOrder> allOrders = orderService
                                .selectRentalOrderList(orderQuery);

                int totalOrders = allOrders.size();
                // 进行中的订单：已支付(1)、租赁中(2)、归还中(3)
                int activeOrders = (int) allOrders.stream()
                                .filter(o -> "1".equals(o.getStatus()) || "2".equals(o.getStatus())
                                                || "3".equals(o.getStatus()))
                                .count();
                // 已完成的订单：已归还(4)
                int completedOrders = (int) allOrders.stream().filter(o -> "4".equals(o.getStatus())).count();

                orderStats.put("total", totalOrders);
                orderStats.put("active", activeOrders);
                orderStats.put("completed", completedOrders);
                data.put("order", orderStats);

                // 收入统计 - 从订单中计算
                Map<String, Object> revenueStats = new HashMap<>();
                java.math.BigDecimal totalRevenue = allOrders.stream()
                                .filter(o -> "4".equals(o.getStatus())) // 只统计已完成的订单
                                .map(o -> o.getRentalAmount() != null ? o.getRentalAmount() : java.math.BigDecimal.ZERO)
                                .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);

                // 本月收入
                java.time.LocalDate now = java.time.LocalDate.now();
                java.time.LocalDate monthStart = now.withDayOfMonth(1);
                java.math.BigDecimal monthRevenue = allOrders.stream()
                                .filter(o -> "4".equals(o.getStatus()) && o.getActualReturnTime() != null)
                                .filter(o -> {
                                        java.time.LocalDate returnDate = o.getActualReturnTime().toInstant()
                                                        .atZone(java.time.ZoneId.systemDefault()).toLocalDate();
                                        return !returnDate.isBefore(monthStart);
                                })
                                .map(o -> o.getRentalAmount() != null ? o.getRentalAmount() : java.math.BigDecimal.ZERO)
                                .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);

                // 今日收入
                java.time.LocalDate today = java.time.LocalDate.now();
                java.math.BigDecimal todayRevenue = allOrders.stream()
                                .filter(o -> "4".equals(o.getStatus()) && o.getActualReturnTime() != null)
                                .filter(o -> {
                                        java.time.LocalDate returnDate = o.getActualReturnTime().toInstant()
                                                        .atZone(java.time.ZoneId.systemDefault()).toLocalDate();
                                        return returnDate.equals(today);
                                })
                                .map(o -> o.getRentalAmount() != null ? o.getRentalAmount() : java.math.BigDecimal.ZERO)
                                .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);

                revenueStats.put("total", totalRevenue);
                revenueStats.put("month", monthRevenue);
                revenueStats.put("today", todayRevenue);
                data.put("revenue", revenueStats);

                // 用户统计 - 从订单中获取不同用户数
                Map<String, Object> userStats = new HashMap<>();
                long totalUsers = allOrders.stream().map(o -> o.getUserId()).distinct().count();
                // 活跃用户：有进行中订单的用户
                long activeUsers = allOrders.stream()
                                .filter(o -> "1".equals(o.getStatus()) || "2".equals(o.getStatus())
                                                || "3".equals(o.getStatus()))
                                .map(o -> o.getUserId())
                                .distinct()
                                .count();
                // 新增用户：本月第一次下单的用户
                long newUsers = allOrders.stream()
                                .filter(o -> o.getCreateTime() != null)
                                .filter(o -> {
                                        java.time.LocalDate createDate = o.getCreateTime().toInstant()
                                                        .atZone(java.time.ZoneId.systemDefault()).toLocalDate();
                                        return !createDate.isBefore(monthStart);
                                })
                                .map(o -> o.getUserId())
                                .distinct()
                                .count();

                userStats.put("total", totalUsers);
                userStats.put("active", activeUsers);
                userStats.put("new", newUsers);
                data.put("user", userStats);

                return success(data);
        }

        /**
         * 获取近7天订单趋势
         */
        @GetMapping("/orderTrend")
        public AjaxResult getOrderTrend() {
                com.ruoyi.rental.domain.RentalOrder query = new com.ruoyi.rental.domain.RentalOrder();
                java.util.List<com.ruoyi.rental.domain.RentalOrder> allOrders = orderService
                                .selectRentalOrderList(query);

                java.time.LocalDate today = java.time.LocalDate.now();
                java.util.List<String> dates = new java.util.ArrayList<>();
                java.util.List<Integer> counts = new java.util.ArrayList<>();

                for (int i = 6; i >= 0; i--) {
                        java.time.LocalDate date = today.minusDays(i);
                        dates.add(date.format(java.time.format.DateTimeFormatter.ofPattern("MM-dd")));

                        int count = (int) allOrders.stream()
                                        .filter(o -> o.getCreateTime() != null)
                                        .filter(o -> {
                                                java.time.LocalDate createDate = o.getCreateTime().toInstant()
                                                                .atZone(java.time.ZoneId.systemDefault()).toLocalDate();
                                                return createDate.equals(date);
                                        })
                                        .count();
                        counts.add(count);
                }

                Map<String, Object> data = new HashMap<>();
                data.put("dates", dates);
                data.put("counts", counts);
                return success(data);
        }

        /**
         * 获取近7天收入趋势
         */
        @GetMapping("/revenueTrend")
        public AjaxResult getRevenueTrend() {
                com.ruoyi.rental.domain.RentalOrder query = new com.ruoyi.rental.domain.RentalOrder();
                java.util.List<com.ruoyi.rental.domain.RentalOrder> allOrders = orderService
                                .selectRentalOrderList(query);

                java.time.LocalDate today = java.time.LocalDate.now();
                java.util.List<String> dates = new java.util.ArrayList<>();
                java.util.List<java.math.BigDecimal> amounts = new java.util.ArrayList<>();

                for (int i = 6; i >= 0; i--) {
                        java.time.LocalDate date = today.minusDays(i);
                        dates.add(date.format(java.time.format.DateTimeFormatter.ofPattern("MM-dd")));

                        java.math.BigDecimal amount = allOrders.stream()
                                        .filter(o -> o.getPayTime() != null)
                                        .filter(o -> {
                                                java.time.LocalDate payDate = o.getPayTime().toInstant()
                                                                .atZone(java.time.ZoneId.systemDefault()).toLocalDate();
                                                return payDate.equals(date);
                                        })
                                        .map(o -> o.getTotalAmount() != null ? o.getTotalAmount()
                                                        : java.math.BigDecimal.ZERO)
                                        .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);
                        amounts.add(amount);
                }

                Map<String, Object> data = new HashMap<>();
                data.put("dates", dates);
                data.put("amounts", amounts);
                return success(data);
        }

        /**
         * 获取设备租赁排行Top5
         */
        @GetMapping("/equipmentRank")
        public AjaxResult getEquipmentRank() {
                com.ruoyi.rental.domain.RentalEquipment equipmentQuery = new com.ruoyi.rental.domain.RentalEquipment();
                equipmentQuery.setDelFlag("0");
                java.util.List<com.ruoyi.rental.domain.RentalEquipment> allEquipment = equipmentService
                                .selectRentalEquipmentList(equipmentQuery);

                // 按totalRented排序取前5
                java.util.List<Map<String, Object>> rankList = allEquipment.stream()
                                .sorted((a, b) -> {
                                        int aCount = a.getTotalRented() != null ? a.getTotalRented() : 0;
                                        int bCount = b.getTotalRented() != null ? b.getTotalRented() : 0;
                                        return bCount - aCount;
                                })
                                .limit(5)
                                .map(e -> {
                                        Map<String, Object> item = new HashMap<>();
                                        item.put("name", e.getEquipmentName());
                                        item.put("value", e.getTotalRented() != null ? e.getTotalRented() : 0);
                                        return item;
                                })
                                .collect(java.util.stream.Collectors.toList());

                return success(rankList);
        }
}
