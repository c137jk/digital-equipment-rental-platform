package com.ruoyi.web.controller.rental;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.rental.domain.RentalOrder;
import com.ruoyi.rental.service.IRentalOrderService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

//订单Controller

@RestController
@RequestMapping("/rental/order")
public class RentalOrderController extends BaseController {
    @Autowired
    private IRentalOrderService rentalOrderService;

    /**
     * 查询订单列表
     */
    @PreAuthorize("@ss.hasPermi('rental:order:list')")
    @GetMapping("/list")
    public TableDataInfo list(RentalOrder rentalOrder) {
        startPage();
        List<RentalOrder> list = rentalOrderService.selectRentalOrderList(rentalOrder);
        return getDataTable(list);
    }

    /**
     * 查询我的订单列表
     */
    @GetMapping("/mylist")
    public TableDataInfo myList(RentalOrder rentalOrder) {
        startPage();
        rentalOrder.setUserId(SecurityUtils.getUserId());
        List<RentalOrder> list = rentalOrderService.selectRentalOrderList(rentalOrder);
        return getDataTable(list);
    }

    /**
     * 导出订单列表
     */
    @PreAuthorize("@ss.hasPermi('rental:order:export')")
    @Log(title = "订单", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, RentalOrder rentalOrder) {
        List<RentalOrder> list = rentalOrderService.selectRentalOrderList(rentalOrder);
        ExcelUtil<RentalOrder> util = new ExcelUtil<RentalOrder>(RentalOrder.class);
        util.exportExcel(response, list, "订单数据");
    }

    /**
     * 获取订单详细信息
     */
    @GetMapping(value = "/{orderId}")
    public AjaxResult getInfo(@PathVariable("orderId") Long orderId) {
        return success(rentalOrderService.selectRentalOrderByOrderId(orderId));
    }

    /**
     * 新增订单
     */
    @Log(title = "订单", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody RentalOrder rentalOrder) {
        rentalOrder.setUserId(SecurityUtils.getUserId());
        rentalOrder.setCreateBy(SecurityUtils.getUsername());
        return toAjax(rentalOrderService.insertRentalOrder(rentalOrder));
    }

    /**
     * 修改订单
     */
    @PreAuthorize("@ss.hasPermi('rental:order:edit')")
    @Log(title = "订单", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody RentalOrder rentalOrder) {
        return toAjax(rentalOrderService.updateRentalOrder(rentalOrder));
    }

    /**
     * 删除订单
     */
    @PreAuthorize("@ss.hasPermi('rental:order:remove')")
    @Log(title = "订单", businessType = BusinessType.DELETE)
    @DeleteMapping("/{orderIds}")
    public AjaxResult remove(@PathVariable Long[] orderIds) {
        return toAjax(rentalOrderService.deleteRentalOrderByOrderIds(orderIds));
    }

    /**
     * 支付订单
     */
    @Log(title = "订单支付", businessType = BusinessType.UPDATE)
    @PutMapping("/pay/{orderId}")
    public AjaxResult pay(@PathVariable Long orderId) {
        return toAjax(rentalOrderService.payOrder(orderId));
    }

    /**
     * 取消订单
     */
    @Log(title = "订单取消", businessType = BusinessType.UPDATE)
    @PutMapping("/cancel/{orderId}")
    public AjaxResult cancel(@PathVariable Long orderId) {
        return toAjax(rentalOrderService.cancelOrder(orderId));
    }

    /**
     * 归还设备
     */
    @Log(title = "归还设备", businessType = BusinessType.UPDATE)
    @PutMapping("/return/{orderId}")
    public AjaxResult returnEquipment(@PathVariable Long orderId) {
        return toAjax(rentalOrderService.returnEquipment(orderId));
    }

    /**
     * 申请归还(用户上传快递单号)
     */
    @Log(title = "申请归还", businessType = BusinessType.UPDATE)
    @PutMapping("/applyReturn")
    public AjaxResult applyReturn(@RequestBody RentalOrder rentalOrder) {
        rentalOrder.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(rentalOrderService.applyReturn(rentalOrder));
    }

    /**
     * 确认发货(管理员:已支付→租赁中)
     */
    @PreAuthorize("@ss.hasPermi('rental:order:edit')")
    @Log(title = "确认发货", businessType = BusinessType.UPDATE)
    @PutMapping("/ship/{orderId}")
    public AjaxResult ship(@PathVariable Long orderId) {
        return toAjax(rentalOrderService.shipOrder(orderId));
    }

    /**
     * 确认收货(管理员:归还中→已归还)
     */
    @PreAuthorize("@ss.hasPermi('rental:order:edit')")
    @Log(title = "确认收货", businessType = BusinessType.UPDATE)
    @PutMapping("/confirmReturn/{orderId}")
    public AjaxResult confirmReturn(@PathVariable Long orderId) {
        return toAjax(rentalOrderService.confirmReturn(orderId));
    }

    /**
     * 确认归还(标记损坏并扣除押金)
     */
    @PreAuthorize("@ss.hasPermi('rental:order:edit')")
    @Log(title = "标记损坏", businessType = BusinessType.UPDATE)
    @PutMapping("/confirmReturnWithDamage/{orderId}")
    public AjaxResult confirmReturnWithDamage(@PathVariable Long orderId,
            @org.springframework.web.bind.annotation.RequestParam java.math.BigDecimal deductAmount,
            @org.springframework.web.bind.annotation.RequestParam String deductReason) {
        return toAjax(rentalOrderService.confirmReturnWithDamage(orderId, deductAmount, deductReason));
    }

    /**
     * 用户申请延期
     */
    @Log(title = "申请延期", businessType = BusinessType.UPDATE)
    @PutMapping("/applyExtend/{orderId}")
    public AjaxResult applyExtend(@PathVariable Long orderId,
            @org.springframework.web.bind.annotation.RequestParam Integer extendDays) {
        return toAjax(rentalOrderService.applyExtend(orderId, extendDays));
    }

    /**
     * 管理员审批延期(批准)
     */
    @PreAuthorize("@ss.hasPermi('rental:order:edit')")
    @Log(title = "审批延期", businessType = BusinessType.UPDATE)
    @PutMapping("/approveExtend/{orderId}")
    public AjaxResult approveExtend(@PathVariable Long orderId) {
        return toAjax(rentalOrderService.approveExtend(orderId, true));
    }

    /**
     * 管理员审批延期(拒绝)
     */
    @PreAuthorize("@ss.hasPermi('rental:order:edit')")
    @Log(title = "拒绝延期", businessType = BusinessType.UPDATE)
    @PutMapping("/rejectExtend/{orderId}")
    public AjaxResult rejectExtend(@PathVariable Long orderId) {
        return toAjax(rentalOrderService.approveExtend(orderId, false));
    }
}
