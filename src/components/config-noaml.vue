<template>

	<div class="config-content">

		<h4>自动卖出</h4>
		<el-form ref="cnomal" :inline="false" :model="form" size="small" label-width="80px">

			<el-form-item label="卖出价格">
				<el-col :span="24" class="layout-left">
					<el-input oninput="value=value.replace(/[^\d.]/g,'')" v-model="form.price"></el-input>
				</el-col>
			</el-form-item>

			<el-form-item label="卖出仓位">
				<el-col :span="24" class="layout-left">
					<el-input oninput="value=value.replace(/[^\d.]/g,'')" v-model="form.percent"></el-input>

				</el-col>
			</el-form-item>

			<el-form-item>
				<div :class="btclass" @click="openAuto">{{btlable}}</div>
			</el-form-item>

		</el-form>




		<div>
			<h4>手动卖出</h4>
		</div>
		<el-form ref="cnomal2" :inline="false" :model="form2" size="small" label-width="80px">


			<el-form-item label="快速仓位">

				<!-- <el-slider v-model="form.persent"></el-slider> -->
				<el-radio-group v-model="form2.percent" @change="setquick">
					<el-radio :label="25">25%</el-radio>
					<el-radio :label="50">50%</el-radio>
					<el-radio :label="75">75%</el-radio>
				</el-radio-group>

			</el-form-item>

			<el-form-item label="当前仓位">
				<el-col :span="24" class="layout-left padding-0">
					<el-input oninput="value=value.replace(/[^\d.]/g,'')" v-model="form2.percent"></el-input>
					<el-button type="warning" size="mini" @click="excuteCmd('manualSell')">手动卖出</el-button>
				</el-col>
			</el-form-item>


		</el-form>

		<div>
			<el-button size="mini" type="primary" @click="centerDialogVisible = true">发送手续费</el-button>
			<el-button size="mini" type="infor" @click="excuteCmd('createWorkers')">创建小号【{{totalNum}}】</el-button>
			<el-button size="mini" type="infor" @click="excuteCmd('batchApprove')">批量授权</el-button>
		</div>

		<div class="tobuy">
			<h4>手动买入</h4>
			<el-button type="primary" @click="excuteCmd('manualBuy')">手动买入</el-button>
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
					percent: 50,
					fee: 0.05, //手续费
				},

				form2: {
					percent: 50, //手动卖出百分比
				},

				totalNum: 0,
				select_childacc: [],
				btclass: 'open-switcher',
				btlable: '立即开启',

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
				this.form2.percent = v;
			},

			openAuto() {
				this.form.autoSell = !this.form.autoSell;
				this.btclass = this.form.autoSell ? "open-switcher-active" : "open-switcher";
				this.btlable = this.form.autoSell ? "点击关闭" : "立即开启";
				this.excuteCmd('sellConfig');

			},

			excuteCmd(v) {

				if (v == "sendFee") {
					this.centerDialogVisible = false;
				}

				if (v == 'sellConfig') {
					this.$emit('submit', v, this.form);
				}

				if (v == "manualSell") {
					this.$emit('submit', v, this.form2);
				}
				
				if (v == "manualBuy") {
					this.$emit('submit', v, this.form2);
				}

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
					if (value.persent) {
						this.from.persent = value.persent;
					}
				}

				if (data.totalNum) {
					this.totalNum = data.totalNum;
				}

				this.btclass = this.form.autoSell ? "open-switcher-active" : "open-switcher";
				this.btlable = this.form.autoSell ? "点击关闭" : "立即开启";
			}


		}
	}
</script>

<style>
	.config-content {
		background-color: #c7cbd2;
	}

	.tobuy {
		margin-top: 30px;
	}

	.open-switcher {
		background-color: #006DCC;
		color: white;
		cursor: pointer;
	}

	.open-switcher-active {
		background-color: #9d9d9d;
		color: white;
		cursor: pointer;
	}

	h4 {
		margin-top: 20px;
		margin-bottom: 8px;
		color: #409EFF;
	}
</style>
