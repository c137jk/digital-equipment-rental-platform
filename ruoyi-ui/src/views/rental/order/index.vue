<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="订单号" prop="orderNo">
        <el-input
          v-model="queryParams.orderNo"
          placeholder="请输入订单号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="设备名称" prop="equipmentName">
        <el-input
          v-model="queryParams.equipmentName"
          placeholder="请输入设备名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="订单状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="待支付" value="0" />
          <el-option label="已支付" value="1" />
          <el-option label="租赁中" value="2" />
          <el-option label="归还中" value="3" />
          <el-option label="已归还" value="4" />
          <el-option label="已取消" value="5" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="orderList">
      <el-table-column label="订单号" align="center" prop="orderNo" width="180" />
      <el-table-column label="用户" align="center" prop="userName" width="100" />
      <el-table-column label="设备名称" align="center" prop="equipmentName" :show-overflow-tooltip="true" />
      <el-table-column label="数量" align="center" prop="quantity" width="60" />
      <el-table-column label="租赁类型" align="center" prop="rentalType" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.rentalType === '1'" type="success">日租</el-tag>
          <el-tag v-else-if="scope.row.rentalType === '2'" type="warning">周租</el-tag>
          <el-tag v-else type="danger">月租</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="开始时间" align="center" prop="startTime" width="160">
        <template slot-scope="scope">
          {{ scope.row.startTime || '-' }}
        </template>
      </el-table-column>
      <el-table-column label="结束时间" align="center" prop="endTime" width="160">
        <template slot-scope="scope">
          {{ scope.row.endTime || '-' }}
        </template>
      </el-table-column>
      <el-table-column label="租金" align="center" prop="rentalAmount" width="100">
        <template slot-scope="scope">
          ¥{{ scope.row.rentalAmount }}
        </template>
      </el-table-column>
      <el-table-column label="押金" align="center" prop="depositAmount" width="100">
        <template slot-scope="scope">
          ¥{{ scope.row.depositAmount }}
        </template>
      </el-table-column>
      <el-table-column label="总金额" align="center" prop="totalAmount" width="100">
        <template slot-scope="scope">
          <span style="color: #f56c6c; font-weight: bold">¥{{ scope.row.totalAmount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status === '0'" type="warning">待支付</el-tag>
          <el-tag v-else-if="scope.row.status === '1'" type="info">已支付</el-tag>
          <el-tag v-else-if="scope.row.status === '2'" type="primary">租赁中</el-tag>
          <el-tag v-else-if="scope.row.status === '3'" type="warning">归还中</el-tag>
          <el-tag v-else-if="scope.row.status === '4'" type="success">已归还</el-tag>
          <el-tag v-else type="danger">已取消</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="160" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="320">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleView(scope.row)"
          >详情</el-button>
          <el-button
            v-if="scope.row.status === '1'"
            size="mini"
            type="text"
            icon="el-icon-s-promotion"
            @click="handleShip(scope.row)"
            v-hasPermi="['rental:order:edit']"
          >确认发货</el-button>
          <el-button
            v-if="scope.row.status === '3'"
            size="mini"
            type="text"
            icon="el-icon-check"
            @click="handleConfirmReturn(scope.row)"
            v-hasPermi="['rental:order:edit']"
          >确认收货</el-button>
          <el-button
            v-if="scope.row.status === '3'"
            size="mini"
            type="text"
            icon="el-icon-warning"
            @click="handleDamage(scope.row)"
            v-hasPermi="['rental:order:edit']"
          >标记损坏</el-button>
          <el-button
            v-if="scope.row.extendStatus === '0'"
            size="mini"
            type="text"
            icon="el-icon-time"
            @click="handleApproveExtend(scope.row)"
            v-hasPermi="['rental:order:edit']"
          >审批延期</el-button>
          <el-button
            v-if="scope.row.extendStatus === '0'"
            size="mini"
            type="text"
            icon="el-icon-close"
            @click="handleRejectExtend(scope.row)"
            v-hasPermi="['rental:order:edit']"
          >拒绝延期</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 订单详情对话框 -->
    <el-dialog title="订单详情" :visible.sync="open" width="800px" append-to-body>
      <el-descriptions :column="2" border v-if="orderDetail">
        <el-descriptions-item label="订单号">{{ orderDetail.orderNo }}</el-descriptions-item>
        <el-descriptions-item label="用户">{{ orderDetail.userName }}</el-descriptions-item>
        <el-descriptions-item label="设备名称">{{ orderDetail.equipmentName }}</el-descriptions-item>
        <el-descriptions-item label="数量">{{ orderDetail.quantity }}</el-descriptions-item>
        <el-descriptions-item label="租赁类型">
          <el-tag v-if="orderDetail.rentalType === '1'">日租</el-tag>
          <el-tag v-else-if="orderDetail.rentalType === '2'">周租</el-tag>
          <el-tag v-else>月租</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="租赁天数">{{ orderDetail.rentalDays || '-' }}</el-descriptions-item>
        <el-descriptions-item label="开始时间">{{ orderDetail.startTime || '-' }}</el-descriptions-item>
        <el-descriptions-item label="结束时间">{{ orderDetail.endTime || '-' }}</el-descriptions-item>
        <el-descriptions-item label="租金">¥{{ orderDetail.rentalAmount }}</el-descriptions-item>
        <el-descriptions-item label="押金">¥{{ orderDetail.depositAmount }}</el-descriptions-item>
        <el-descriptions-item label="总金额">
          <span style="color: #f56c6c; font-weight: bold">¥{{ orderDetail.totalAmount }}</span>
        </el-descriptions-item>
        <el-descriptions-item label="订单状态">
          <el-tag v-if="orderDetail.status === '0'" type="warning">待支付</el-tag>
          <el-tag v-else-if="orderDetail.status === '1'" type="info">已支付</el-tag>
          <el-tag v-else-if="orderDetail.status === '2'" type="primary">租赁中</el-tag>
          <el-tag v-else-if="orderDetail.status === '3'" type="warning">归还中</el-tag>
          <el-tag v-else-if="orderDetail.status === '4'" type="success">已归还</el-tag>
          <el-tag v-else type="danger">已取消</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ orderDetail.createTime }}</el-descriptions-item>
        <el-descriptions-item label="支付时间">{{ orderDetail.payTime || '-' }}</el-descriptions-item>
      </el-descriptions>
      
      <!-- 收货地址 -->
      <el-descriptions v-if="orderDetail && orderDetail.receiverName" title="收货地址" :column="2" border style="margin-top: 20px">
        <el-descriptions-item label="收货人">{{ orderDetail.receiverName }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ orderDetail.receiverPhone }}</el-descriptions-item>
        <el-descriptions-item label="收货地址" :span="2">{{ orderDetail.receiverAddress }}</el-descriptions-item>
      </el-descriptions>
      
      <!-- 归还信息 -->
      <el-descriptions v-if="orderDetail && orderDetail.returnExpressNo" title="归还信息" :column="2" border style="margin-top: 20px">
        <el-descriptions-item label="快递公司">{{ orderDetail.returnExpressCompany }}</el-descriptions-item>
        <el-descriptions-item label="快递单号">{{ orderDetail.returnExpressNo }}</el-descriptions-item>
        <el-descriptions-item label="申请时间" :span="2">{{ orderDetail.returnApplyTime }}</el-descriptions-item>
      </el-descriptions>
      
      <el-descriptions v-if="orderDetail" :column="1" border style="margin-top: 20px">
        <el-descriptions-item label="用户备注">{{ orderDetail.userRemark || '-' }}</el-descriptions-item>
        <el-descriptions-item label="管理员备注">{{ orderDetail.adminRemark || '-' }}</el-descriptions-item>
      </el-descriptions>
      <div slot="footer" class="dialog-footer">
        <el-button @click="open = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 损坏标记弹窗 -->
    <el-dialog title="标记设备损坏" :visible.sync="damageOpen" width="500px" append-to-body>
      <el-form label-width="100px">
        <el-form-item label="抣除金额">
          <el-input-number v-model="damageForm.deductAmount" :min="0" :precision="2" />
        </el-form-item>
        <el-form-item label="损坏原因">
          <el-input v-model="damageForm.deductReason" type="textarea" :rows="3" placeholder="请描述设备损坏情况" />
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="damageOpen = false">取消</el-button>
        <el-button type="primary" @click="submitDamage">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listOrder, getOrder, shipOrder, confirmReturn, confirmReturnWithDamage, approveExtend, rejectExtend } from "@/api/rental/order";

export default {
  name: "Order",
  data() {
    return {
      loading: true,
      showSearch: true,
      total: 0,
      orderList: [],
      orderDetail: null,
      open: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        orderNo: null,
        equipmentName: null,
        status: null
      },
      damageOpen: false,
      damageOrderId: null,
      damageForm: {
        deductAmount: 0,
        deductReason: ''
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      this.loading = true;
      listOrder(this.queryParams).then(response => {
        this.orderList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handleView(row) {
      getOrder(row.orderId).then(response => {
        this.orderDetail = response.data;
        this.open = true;
      });
    },
    handleShip(row) {
      this.$modal.confirm('确认已发货？设备将进入租赁中状态').then(function() {
        return shipOrder(row.orderId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("发货成功");
      }).catch(() => {});
    },
    handleConfirmReturn(row) {
      this.$modal.confirm('确认已收到归还设备？将退还押金').then(function() {
        return confirmReturn(row.orderId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("确认收货成功，押金已退还");
      }).catch(() => {});
    },
    handleDamage(row) {
      this.damageOrderId = row.orderId;
      this.damageForm = { deductAmount: 0, deductReason: '' };
      this.damageOpen = true;
    },
    submitDamage() {
      if (!this.damageForm.deductReason) {
        this.$modal.msgWarning('请填写损坏原因');
        return;
      }
      confirmReturnWithDamage(this.damageOrderId, this.damageForm.deductAmount, this.damageForm.deductReason).then(() => {
        this.getList();
        this.damageOpen = false;
        this.$modal.msgSuccess('已标记损坏并扣除押金');
      });
    },
    handleApproveExtend(row) {
      this.$modal.confirm('确认批准延期 ' + row.extendDays + ' 天？延期费用¥' + row.extendFee).then(function() {
        return approveExtend(row.orderId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess('延期已批准');
      }).catch(() => {});
    },
    handleRejectExtend(row) {
      this.$modal.confirm('确认拒绝延期申请？').then(function() {
        return rejectExtend(row.orderId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess('延期已拒绝');
      }).catch(() => {});
    }
  }
};
</script>
