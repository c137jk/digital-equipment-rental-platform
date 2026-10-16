package com.ruoyi.web.controller.rental;

import java.util.List;
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
import com.ruoyi.rental.domain.RentalCart;
import com.ruoyi.rental.service.IRentalCartService;


//购物车Controller
@RestController
@RequestMapping("/rental/cart")
public class RentalCartController extends BaseController {
    @Autowired
    private IRentalCartService rentalCartService;

    /**
     * 查询我的购物车列表
     */
    @GetMapping("/list")
    public AjaxResult list() {
        Long userId = SecurityUtils.getUserId();
        List<RentalCart> list = rentalCartService.selectRentalCartListByUserId(userId);
        return success(list);
    }

    /**
     * 添加到购物车
     */
    @Log(title = "购物车", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody RentalCart rentalCart) {
        rentalCart.setUserId(SecurityUtils.getUserId());
        return toAjax(rentalCartService.insertRentalCart(rentalCart));
    }

    /**
     * 修改购物车
     */
    @Log(title = "购物车", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody RentalCart rentalCart) {
        return toAjax(rentalCartService.updateRentalCart(rentalCart));
    }

    /**
     * 删除购物车
     */
    @Log(title = "购物车", businessType = BusinessType.DELETE)
    @DeleteMapping("/{cartIds}")
    public AjaxResult remove(@PathVariable Long[] cartIds) {
        return toAjax(rentalCartService.deleteRentalCartByCartIds(cartIds));
    }

    /**
     * 清空购物车
     */
    @Log(title = "清空购物车", businessType = BusinessType.DELETE)
    @DeleteMapping("/clear")
    public AjaxResult clear() {
        Long userId = SecurityUtils.getUserId();
        return toAjax(rentalCartService.clearCart(userId));
    }
}
