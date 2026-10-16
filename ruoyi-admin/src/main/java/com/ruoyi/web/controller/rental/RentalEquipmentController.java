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
import com.ruoyi.rental.domain.RentalEquipment;
import com.ruoyi.rental.service.IRentalEquipmentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;


//设备Controller

@RestController
@RequestMapping("/rental/equipment")
public class RentalEquipmentController extends BaseController {
    @Autowired
    private IRentalEquipmentService rentalEquipmentService;

    /**
     * 查询设备列表 (公开接口,无需权限)
     */
    @GetMapping("/list")
    public TableDataInfo list(RentalEquipment rentalEquipment) {
        startPage();
        List<RentalEquipment> list = rentalEquipmentService.selectRentalEquipmentList(rentalEquipment);
        return getDataTable(list);
    }

    /**
     * 导出设备列表
     */
    @PreAuthorize("@ss.hasPermi('rental:equipment:export')")
    @Log(title = "设备", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, RentalEquipment rentalEquipment) {
        List<RentalEquipment> list = rentalEquipmentService.selectRentalEquipmentList(rentalEquipment);
        ExcelUtil<RentalEquipment> util = new ExcelUtil<RentalEquipment>(RentalEquipment.class);
        util.exportExcel(response, list, "设备数据");
    }

    /**
     * 获取设备详细信息 (公开接口,无需权限)
     */
    @GetMapping(value = "/{equipmentId}")
    public AjaxResult getInfo(@PathVariable("equipmentId") Long equipmentId) {
        return success(rentalEquipmentService.selectRentalEquipmentByEquipmentId(equipmentId));
    }

    /**
     * 新增设备
     */
    @PreAuthorize("@ss.hasPermi('rental:equipment:add')")
    @Log(title = "设备", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody RentalEquipment rentalEquipment) {
        return toAjax(rentalEquipmentService.insertRentalEquipment(rentalEquipment));
    }

    /**
     * 修改设备
     */
    @PreAuthorize("@ss.hasPermi('rental:equipment:edit')")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody RentalEquipment rentalEquipment) {
        return toAjax(rentalEquipmentService.updateRentalEquipment(rentalEquipment));
    }

    /**
     * 删除设备
     */
    @PreAuthorize("@ss.hasPermi('rental:equipment:remove')")
    @Log(title = "设备", businessType = BusinessType.DELETE)
    @DeleteMapping("/{equipmentIds}")
    public AjaxResult remove(@PathVariable Long[] equipmentIds) {
        return toAjax(rentalEquipmentService.deleteRentalEquipmentByEquipmentIds(equipmentIds));
    }

    /**
     * 热门设备 (公开接口,按租赁次数排序)
     */
    @GetMapping("/hot")
    public AjaxResult hot() {
        RentalEquipment query = new RentalEquipment();
        query.setStatus("0");
        List<RentalEquipment> list = rentalEquipmentService.selectRentalEquipmentList(query);
        // 按totalRented降序排序，取前6
        list.sort((a, b) -> {
            int aCount = a.getTotalRented() != null ? a.getTotalRented() : 0;
            int bCount = b.getTotalRented() != null ? b.getTotalRented() : 0;
            return bCount - aCount;
        });
        if (list.size() > 6) {
            list = list.subList(0, 6);
        }
        return success(list);
    }

    /**
     * 同类推荐 (公开接口,相同分类的其他设备)
     */
    @GetMapping("/recommend/{equipmentId}")
    public AjaxResult recommend(@PathVariable("equipmentId") Long equipmentId) {
        // 先获取当前设备信息
        RentalEquipment current = rentalEquipmentService.selectRentalEquipmentByEquipmentId(equipmentId);
        if (current == null) {
            return success(new java.util.ArrayList<>());
        }
        // 查询同分类设备
        RentalEquipment query = new RentalEquipment();
        query.setCategoryId(current.getCategoryId());
        query.setStatus("0");
        List<RentalEquipment> list = rentalEquipmentService.selectRentalEquipmentList(query);
        // 排除当前设备，取前4个
        list.removeIf(e -> e.getEquipmentId().equals(equipmentId));
        if (list.size() > 4) {
            list = list.subList(0, 4);
        }
        return success(list);
    }
}
