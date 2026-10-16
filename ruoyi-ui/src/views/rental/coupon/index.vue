<template>
  <div class="app-container">
    <!-- 搜索 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="优惠码" prop="couponCode">
        <el-input v-model="queryParams.couponCode" placeholder="请输入优惠码" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="启用" value="0" />
          <el-option label="禁用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 工具栏 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['rental:coupon:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['rental:coupon:remove']">删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 表格 -->
    <el-table v-loading="loading" :data="couponList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="优惠码" align="center" prop="couponCode" />
      <el-table-column label="名称" align="center" prop="couponName" />
      <el-table-column label="折扣类型" align="center" prop="discountType">
        <template slot-scope="scope">
          {{ scope.row.discountType === '1' ? '百分比折扣' : '固定金额' }}
        </template>
      </el-table-column>
      <el-table-column label="折扣值" align="center" prop="discountValue">
        <template slot-scope="scope">
          {{ scope.row.discountType === '1' ? (scope.row.discountValue * 10).toFixed(1) + '折' : '¥' + scope.row.discountValue }}
        </template>
      </el-table-column>
      <el-table-column label="最低消费" align="center" prop="minAmount">
        <template slot-scope="scope">¥{{ scope.row.minAmount }}</template>
      </el-table-column>
      <el-table-column label="使用次数" align="center">
        <template slot-scope="scope">
          {{ scope.row.useCount }} / {{ scope.row.maxUse === -1 ? '无限' : scope.row.maxUse }}
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">{{ scope.row.status === '0' ? '启用' : '禁用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="有效期" align="center" min-width="200">
        <template slot-scope="scope">
          {{ scope.row.startTime || '不限' }} ~ {{ scope.row.endTime || '不限' }}
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="160">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['rental:coupon:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['rental:coupon:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 添加/修改对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="couponForm" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="优惠码" prop="couponCode">
          <el-input v-model="form.couponCode" placeholder="请输入优惠码" />
        </el-form-item>
        <el-form-item label="名称" prop="couponName">
          <el-input v-model="form.couponName" placeholder="请输入优惠券名称" />
        </el-form-item>
        <el-form-item label="折扣类型" prop="discountType">
          <el-radio-group v-model="form.discountType">
            <el-radio label="1">百分比折扣</el-radio>
            <el-radio label="2">固定金额</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="折扣值" prop="discountValue">
          <el-input-number v-model="form.discountValue" :min="0" :step="0.1" />
          <span style="margin-left: 10px; color: #999">{{ form.discountType === '1' ? '(如0.8代表8折)' : '(固定优惠金额)' }}</span>
        </el-form-item>
        <el-form-item label="最低消费" prop="minAmount">
          <el-input-number v-model="form.minAmount" :min="0" />
        </el-form-item>
        <el-form-item label="最大使用次数" prop="maxUse">
          <el-input-number v-model="form.maxUse" :min="-1" />
          <span style="margin-left: 10px; color: #999">(-1表示无限制)</span>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="0">启用</el-radio>
            <el-radio label="1">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="生效时间">
          <el-date-picker v-model="form.startTime" type="datetime" placeholder="开始时间" value-format="yyyy-MM-dd HH:mm:ss" />
          ~
          <el-date-picker v-model="form.endTime" type="datetime" placeholder="结束时间" value-format="yyyy-MM-dd HH:mm:ss" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancel">取消</el-button>
        <el-button type="primary" @click="submitForm">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listCoupon, addCoupon, updateCoupon, delCoupon } from '@/api/rental/coupon'

export default {
  name: 'Coupon',
  data() {
    return {
      loading: true,
      showSearch: true,
      ids: [],
      multiple: true,
      total: 0,
      couponList: [],
      title: '',
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        couponCode: null,
        status: null
      },
      form: {},
      rules: {
        couponCode: [{ required: true, message: '优惠码不能为空', trigger: 'blur' }],
        couponName: [{ required: true, message: '名称不能为空', trigger: 'blur' }],
        discountValue: [{ required: true, message: '折扣值不能为空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listCoupon(this.queryParams).then(response => {
        this.couponList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm('queryForm')
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.couponId)
      this.multiple = !selection.length
    },
    reset() {
      this.form = {
        couponId: null,
        couponCode: '',
        couponName: '',
        discountType: '1',
        discountValue: 0.8,
        minAmount: 0,
        maxUse: -1,
        status: '0',
        startTime: null,
        endTime: null
      }
      this.resetForm('couponForm')
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = '新增优惠券'
    },
    handleUpdate(row) {
      this.reset()
      this.form = Object.assign({}, row)
      this.open = true
      this.title = '修改优惠券'
    },
    submitForm() {
      this.$refs['couponForm'].validate(valid => {
        if (valid) {
          if (this.form.couponId != null) {
            updateCoupon(this.form).then(() => {
              this.$modal.msgSuccess('修改成功')
              this.open = false
              this.getList()
            })
          } else {
            addCoupon(this.form).then(() => {
              this.$modal.msgSuccess('新增成功')
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const couponIds = row.couponId || this.ids
      this.$modal.confirm('确认删除选中的优惠券？').then(() => {
        return delCoupon(couponIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess('删除成功')
      }).catch(() => {})
    },
    cancel() {
      this.open = false
      this.reset()
    }
  }
}
</script>
