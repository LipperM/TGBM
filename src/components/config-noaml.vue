<template>

	<div class="config-content">
		<el-form ref="cnomal" :inline="false" :model="form" size="small" label-width="80px">


			<el-form-item label="价格">

				<el-col :span="24" class="layout-left">
					<el-input oninput="value=value.replace(/[^\d.]/g,'')" v-model="form.price"></el-input>
					<el-tooltip class="item" effect="dark" content="自动卖出" placement="top">
						<el-switch v-model="form.autoSell" @change="excuteCmd('sellConfig')">
						</el-switch>

					</el-tooltip>

				</el-col>
			</el-form-item>



			<el-form-item label="快速仓位">

				<!-- <el-slider v-model="form.persent"></el-slider> -->
				<el-radio-group v-model="form.manualSell" @change="setquick">
					<el-radio :label="25">25%</el-radio>
					<el-radio :label="50">50%</el-radio>
					<el-radio :label="75">75%</el-radio>
				</el-radio-group>

			</el-form-item>

			<el-form-item label="当前仓位">
				<el-col :span="24" class="layout-left padding-0">
					<el-input oninput="value=value.replace(/[^\d.]/g,'')" v-model="form.manualSell"></el-input>
					<el-button type="warning" size="mini" @click="excuteCmd('manualSell')">手动卖出</el-button>
				</el-col>
			</el-form-item>


			<el-form-item label="已有小号" v-show="false">

				<el-col :span="24" class="layout-left padding-0">

					<el-select v-model="select_childacc" multiple placeholder="选择小号">
						<el-option v-for="item in child_acc" :key="item.value" :label="item.label" :value="item.value">
						</el-option>
					</el-select>
				</el-col>
			</el-form-item>


			<el-form-item>


			</el-form-item>


		</el-form>

		<div>
			<el-button size="mini" type="primary" @click="centerDialogVisible = true">发送手续费</el-button>
			<el-button size="mini" type="infor" @click="excuteCmd('createWorkers')">创建小号【{{totalNum}}】</el-button>
			<el-button size="mini" type="infor" @click="excuteCmd('batchApprove')">批量授权</el-button>
		</div>


		<el-dialog title="发送手续费" :visible.sync="centerDialogVisible" width="30%" center>
			<el-input oninput="value=value.replace(/[^\d.]/g,'')" placeholder="请输入手续费" v-model="form.fee"></el-input>

			<span slot="footer" class="dialog-footer">
				<el-button @click="centerDialogVisible = false">取 消</el-button>
				<el-button type="primary" @click="excuteCmd('sendFee')">发 送</el-button>
			</span>
		</el-dialog>

	</div>

</template>

<script>
	export default {
		data() {
			return {
				form: {
					autoSell: false,
					price: 0,
					manualSell: 50, //手动卖出百分比
					fee: 0.05, //手续费
				},
				totalNum: 0,
				select_childacc: [],

				child_acc: [{
					value: 'acc1',
					label: '账号1'
				}, {
					value: 'acc2',
					label: '账号2'
				}, {
					value: 'acc3',
					label: '账号3'
				}, {
					value: 'acc4',
					label: '账号4'
				}, {
					value: 'acc5',
					label: '账号5'
				}],
				quick: 1,
				centerDialogVisible: false,
			};
		},
		created() {
			this.getConfig();
			this.getWorkNum();
		},
		methods: {

			getConfig() {
				//this.$emit('submit', 'getSellConfig', this.form);
			},

			getWorkNum() {
				this.$emit('submit', 'workerNum', this.form);
			},

			setquick(v) {
				this.form.manualSell = v;
			},

			excuteCmd(v) {

				if (v == "sendFee") {
					this.centerDialogVisible = false;
				}
				this.$emit('submit', v, this.form);
			},
			inval(data) {
				console.log(data);
				let value = data.sellConfig;
				
				if (value) {
					if (value.autoSell) {
						this.form.autoSell = value.autoSell;
					}
					if (value.price) {
						this.form.price = value.price;
					}
					if (value.totalNum) {
						this.totalNum = value.totalNum;
					}
				}

				if (data.totalNum) {
					this.totalNum = data.totalNum;
				}
			}


		}
	}
</script>

<style>
	.config-content {
		background-color: #c7cbd2;
	}
</style>
