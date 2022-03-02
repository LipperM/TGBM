<template>

	<div class="config-content">

		<el-form ref="config" :model="form" size="small" label-width="80px" class="base-form">

			<el-form-item label="当前配置">
				<el-col :span="24" class="layout-left padding-0">
					<el-select v-model="index" placeholder="请选择当前配置" @change="setItem">

						<el-option v-for="(item,index) in dataList"
							:label="item.tokenSymbol+'【'+fomatTime(item.launchTime)+'】'" :value="index">
						</el-option>

					</el-select>
					<el-button class="margin-l-8" type="info" size="small" @click="excuteCmd('activeConfig')">
						{{activeState}}
					</el-button>
				</el-col>

			</el-form-item>

			<el-form-item label="代币地址">
				<el-col :span="24" class="layout-left padding-0">
					<el-input placeholder="请输入代币地址" v-model="form.tokenAddress" @blur="excuteCheck('token')"></el-input>
					<el-button disabled class="margin-l-8" type="primary" size="small">{{form.tokenSymbol}}
					</el-button>
				</el-col>
			</el-form-item>

			<el-form-item label="快捷地址">

				<el-button type="primary" size="mini" @click="quickbnb('wbnb')">WBNB</el-button>
				<el-button type="primary" size="mini" @click="quickbnb('usdt')">USDT</el-button>
				<el-button type="primary" size="mini" @click="quickbnb('busd')">BUSD</el-button>

			</el-form-item>

			<el-form-item label="资产地址">
				<el-col :span="24" class="layout-left padding-0">
					<el-input placeholder="请输入资产地址" v-model="form.assetAddress" @blur="excuteCheck('asset')"></el-input>
					<el-button disabled class=" margin-l-8" type="primary" size="small">{{form.assetSymbol}}
					</el-button>
				</el-col>
			</el-form-item>

			<el-form-item label="项目方">
				<el-col :span="24" class="layout-left padding-0">
					<el-input placeholder="请输入项目方" v-model="form.tokenOwner"></el-input>

				</el-col>
			</el-form-item>

			<el-form-item label="默认价格">
				<el-col :span="24" class="layout-left padding-0">
					<el-input oninput="value=value.replace(/[^\d.]/g,'')" placeholder="请输入默认价格"
						v-model="form.defaultPrice"></el-input>

				</el-col>
			</el-form-item>

			<el-form-item label="买入滑点">
				<el-col :span="24" class="layout-left padding-0">
					<el-input oninput="value=value.replace(/[^\d]/g,'')" placeholder="请输入买入滑点" maxlength=2 v-model="form.slippage">
					</el-input>

				</el-col>
			</el-form-item>

			<el-form-item label="买入总量">
				<el-col :span="24" class="layout-left padding-0">
					<el-input oninput="value=value.replace(/[^\d.]/g,'')" placeholder="请输入买入总量" v-model="form.buyTotal">
					</el-input>

				</el-col>
			</el-form-item>


			<el-form-item label="最大交易">
				<el-col :span="16" class="layout-left padding-0">
					<el-input placeholder="请输入最大交易" oninput="value=value.replace(/[^\d.]/g,'')"
						v-model="form.maxTransaction"></el-input>
				</el-col>
				<el-col :span="8" class="layout-left padding-8">
					<el-switch v-model="form.limitTransaction" active-color="#13ce66" inactive-color="#ff4949">
					</el-switch>
				</el-col>
			</el-form-item>

			<el-form-item label="最大钱包">
				<el-col :span="16" class="layout-left padding-0">
					<el-input placeholder="请输入最大钱包" oninput="value=value.replace(/[^\d.]/g,'')"
						v-model="form.maxBalance"></el-input>
				</el-col>
				<el-col :span="8" class="layout-left padding-8">
					<el-switch v-model="form.limitBalance" active-color="#13ce66" inactive-color="#ff4949">
					</el-switch>
				</el-col>
			</el-form-item>


			<el-form-item label="发射时间">
				<el-col :span="24" class="layout-left padding-0">
					<el-date-picker v-model="form.launchTime" type="datetime" placeholder="选择日期时间"
						default-time="12:00:00">
					</el-date-picker>
				</el-col>
			</el-form-item>

			<el-form-item label="指定区块" v-show="false">
				<el-input placeholder="请输入指定区块" oninput="value=value.replace(/[^\d]/g,'')" v-model="form.specialBlockNum"></el-input>
			</el-form-item>

			<el-form-item label="发射方式">
				<el-col :span="24" class="layout-left padding-0">


					<el-select v-model="form.launchType" multiple placeholder="请选择发射方式">
						<el-option v-for="item in launchValue" :key="item.value" :label="item.label"
							:value="item.value">
						</el-option>
					</el-select>
				</el-col>
			</el-form-item>



			<el-form-item label="延迟发射">
				<el-col :span="24" class="layout-left padding-0">


					<el-select :clearable='true' v-model="form.delayType" placeholder="请选择延迟发射">
						<el-option v-for="item in delayTypeValue" :key="item.value" :label="item.label"
							:value="item.value">
						</el-option>
					</el-select>
				</el-col>
			</el-form-item>

			<el-form-item label="延迟区块">
				<el-input placeholder="请输入延迟区块数"  oninput="value=value.replace(/[^\d]/g,'')" v-model="form.delayBlockNum"></el-input>
			</el-form-item>

			<el-form-item label="延迟时间">
				<el-input placeholder="请输入延迟时间" oninput="value=value.replace(/[^\d]/g,'')" v-model="form.delayTime"></el-input>
			</el-form-item>

			<el-form-item label="pinkSale">
				<el-input placeholder="请输入pinkSale地址" v-model="form.pinkSaleAddress"></el-input>
			</el-form-item>

			<el-form-item label="方法ID">
				<el-input placeholder="请输入方法ID" v-model="form.methodId"></el-input>
			</el-form-item>

			<el-form-item label="方法名">
				<el-input placeholder="请输入方法名" v-model="form.methodName"></el-input>
			</el-form-item>


			<el-form-item label="撤池方式">
				<el-col :span="24" class="layout-left padding-0">


					<el-select v-model="form.exitType" multiple placeholder="请选择撤池方式">
						<el-option v-for="item in exitTypeValue" :key="item.value" :label="item.label"
							:value="item.value">
						</el-option>
					</el-select>
				</el-col>
			</el-form-item>

			<el-form-item label="费率方法">
				<el-input placeholder="请输入费率方法" v-model="form.exitFeeMethodName"></el-input>
			</el-form-item>

			<el-form-item label="费率参数">
				<el-input placeholder="请输入费率参数" v-model="form.exitFeeMethodParams"></el-input>
			</el-form-item>

			<el-form-item label="使用小号">
				<el-input placeholder="请输入使用小号数量" oninput="value=value.replace(/[^\d]/g,'')" v-model="form.workerNum">
				</el-input>
			</el-form-item>

			<el-form-item>
				<el-button type="primary" size="medium" @click="excuteCmd('saveConfig')">保存</el-button>
				<el-button type="info" size="medium" @click="excuteCmd('delConfig')">删除</el-button>
			</el-form-item>


		</el-form>

	</div>

</template>

<script>
	export default {
		data() {
			return {
				index: '',
				activeToken: '',
				activeState: '未激活',
				form: {
					id: '',
					tokenAddress: '', //代币地址
					tokenSymbol: '-',
					assetAddress: '', // 资产地址
					assetSymbol: '-',
					tokenOwner: '', // 代币操作人
					defaultPrice: '', // 默认价格
					slippage: '', // 买入滑点
					buyTotal: '', // 买入总量
					limitTransaction: false, // 限制交易量
					maxTransaction: '', // 最大交易量
					limitBalance: false, // 限制钱包
					maxBalance: '', // 最大钱包数量
					launchTime: '', // 发射时间
					launchType: [], // 发射方式
					methodId: '', // 方法id
					methodName: '', // 方法名
					delayType: '', //延迟发射
					delayBlockNum: '', // 延迟区块数
					delayTime: '', //延迟时间
					pinkSaleAddress: '',
					specialBlockNum: '', //指定区块
					workerNum: '0', //使用小号数量 
					exitType: '', // 撤池方式
					exitFeeMethodName: '', // 费率方法名
					exitFeeMethodParams: '', //费率参数,
				},

				launchValue: [{
					value: 'addLiquidityETH',
					label: 'addLiquidityETH'
				}, {
					value: 'addLiquidity',
					label: 'addLiquidity'
				}, {
					value: 'pinksale',
					label: 'pinksale'
				}, {
					value: 'methodId',
					label: 'methodId'
				}, {
					value: 'methodName',
					label: 'methodName'
				}],

				exitTypeValue: [{
					value: 'removeLiquidity',
					label: 'removeLiquidity'
				}, {
					value: 'approveLp',
					label: 'approveLp'
				}, {
					value: 'setFee',
					label: 'setFee'
				}],

				delayTypeValue: [{
					value: 'blockDelay',
					label: 'blockDelay'
				}, {
					value: 'timeDelay',
					label: 'timeDelay'
				}],
				dataList: [],

			};
		},
		props: {

		},

		created() {
			this.getConfig();
		},

		methods: {

			getConfig() {
				this.$emit('submit', 'getConfig', this.form);
			},

			setItem(id) {

				if (id <= this.dataList.length) {
					this.form = this.dataList[id];
				} else {
					this.resetForm();
				}

				if (this.form.tokenAddress.toLowerCase() == this.activeToken.toLowerCase()) {
					this.activeState = '已激活';
				} else {
					this.activeState = '未激活';
				}
				
				this.$emit('change', this.form);
			},

			fomatTime(v) {
				return this.FomatTime(v);
			},

			quickbnb(v) {
				switch (v) {
					case 'busd':
						this.form.assetAddress = '0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56';
						break;
					case 'usdt':
						this.form.assetAddress = '0x55d398326f99059fF775485246999027B3197955';
						break;
					case 'wbnb':
						this.form.assetAddress = '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c';
						break;
				}
				this.form.assetSymbol = v;
			},

			excuteCmd(v) {
				this.$emit('submit', v, this.form);
			},

			excuteCheck(v) {
				this.$emit('submit', v, this.form);
			},

			inval(list) {

				this.dataList = list.configList;
				this.index = 0;
				this.activeToken = list.activeToken;
				if (this.dataList != null && this.dataList.length > 0) {

					if (list.activeToken) {
						for (var temp = 0; temp < this.dataList.length; temp++) {
							if (this.dataList[temp].tokenAddress.toLowerCase() == list.activeToken.toLowerCase()) {
								this.index = temp;
							}
						}
					}
					this.form = this.dataList[this.index];
				} else {
					this.resetForm();
				}

				if (this.form.tokenAddress.toLowerCase() == this.activeToken.toLowerCase()) {
					this.activeState = '已激活';
				}
				
				this.$emit('change', this.form);

			},
			resetForm() {
				this.index = '';
				this.form = {
					id: '',
					tokenAddress: '', //代币地址
					tokenSymbol: '',
					assetAddress: '', // 资产地址
					assetSymbol: '-',
					tokenOwner: '', // 代币操作人
					defaultPrice: '', // 默认价格
					slippage: '', // 买入滑点
					buyTotal: '', // 买入总量
					limitTransaction: false, // 限制交易量
					maxTransaction: '', // 最大交易量
					limitBalance: false, // 限制钱包
					maxBalance: '', // 最大钱包数量
					launchTime: '', // 发射时间
					launchType: [], // 发射方式
					methodId: '', // 方法id
					methodName: '', // 方法名
					delayType: '', //延迟发射
					delayBlockNum: '', // 延迟区块数
					delayTime: '', //延迟时间
					specialBlockNum: '', //指定区块
					workerNum: '0', //使用小号数量 
					exitType: '', // 撤池方式
					exitFeeMethodName: '', // 费率方法名
					exitFeeMethodParams: '', //费率参数,
				}
			}
		}
	}
</script>

<style>
	.config-content {
		background-color: #dadee6;
		padding: 10px;
		overflow-y: auto !important;
	}

	.base-form {
		/* overflow-y: auto !important; */
	}
</style>
