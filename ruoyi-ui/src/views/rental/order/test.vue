<template>
  <div class="app-container">
    <h2>订单管理测试页面</h2>
    <p>如果能看到这段文字,说明页面可以加载</p>
    
    <el-button @click="testAPI" type="primary">测试API</el-button>
    
    <div v-if="testResult">
      <h3>测试结果:</h3>
      <pre>{{ testResult }}</pre>
    </div>
    
    <div v-if="error" style="color: red;">
      <h3>错误信息:</h3>
      <pre>{{ error }}</pre>
    </div>
  </div>
</template>

<script>
import { listOrder } from "@/api/rental/order";

export default {
  name: "OrderTest",
  data() {
    return {
      testResult: null,
      error: null
    };
  },
  mounted() {
    console.log("订单测试页面已加载");
    this.testAPI();
  },
  methods: {
    testAPI() {
      console.log("开始测试API...");
      this.error = null;
      this.testResult = null;
      
      listOrder({ pageNum: 1, pageSize: 10 })
        .then(response => {
          console.log("API响应:", response);
          this.testResult = JSON.stringify(response, null, 2);
        })
        .catch(err => {
          console.error("API错误:", err);
          this.error = err.message || JSON.stringify(err);
        });
    }
  }
};
</script>
