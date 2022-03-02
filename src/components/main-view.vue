<template>
	<div class="content full">

		<el-row :gutter="10" class="full">
			<el-col :span="5" class="left">
				<TopSwitcher @click="switchTab"></TopSwitcher>

				<ConfigView ref="baseConfigView" v-show="viewtype == 0" class="config-view" @submit='sendCmd'
					@change="changeForm">
				</ConfigView>
				<ConfigNomal ref="nomalConfigView" v-show="viewtype == 1" class="config-nomal" @submit='sendCmd'>
				</ConfigNomal>

			</el-col>

			<el-col :span="19" class="full-h">


				<el-row>
					<el-col :span="18" class="t1">
						<TableLog ref='tabelT1' :sort="t1Sort" title="成交监控" :files="table1" :dataList="list1">
						</TableLog>
					</el-col>

					<el-col :span="6">

						<div class="layout-center view-tip">
							<i class="el-icon-sort bt-sort" @click="setPriceType"></i>
							<h4>持有</h4>
							<p class="view-tip-color">{{currentTotle}} <span>【{{symbol}}】</span></p>
							<p class="view-tip-color">{{currentTotle * currentNPrice}} <span>【{{symbol2}}】</span></p>

							<h4>资金池</h4>
							<p class="view-tip-color">{{pricePool}} <span>【{{symbol2}}】</span></p>
							<h4>{{lable001}}</h4>
							<p class="view-tip-color">{{priceValue}} <span></span></p>
						</div>

					</el-col>
				</el-row>

				<!-- 	<el-row class="t1">
					<TableLog title="成交监控" :files="table1" :dataList="list1"></TableLog>
				</el-row> -->


				<el-row :gutter="10" class="t-d">

					<el-col :span="12" class="t2">
						<TableLog ref='tabelT2' title="代币监控" :sort="t2Sort" :files="table2" :dataList="list2">
						</TableLog>
					</el-col>

					<el-col :span="12" class="t3">
						<TableLog ref='tabelT3' title="项目方监控" :files="table3" :dataList="list3"></TableLog>
					</el-col>
				</el-row>



			</el-col>




		</el-row>



	</div>
</template>

<script>
	import TopSwitcher from './top-switcher.vue'
	import ConfigView from './config-view.vue'
	import ConfigNomal from './config-noaml.vue'
	import TableLog from './table-log.vue'
	import SockJS from 'sockjs-client'
	import Stomp from 'stompjs'

	export default {
		name: 'MainView',
		components: {
			TopSwitcher,
			ConfigView,
			ConfigNomal,
			TableLog
		},
		data() {
			return {
				stompClient: '',
				headers: {},
				viewtype: 0,
				host: '',
				currentPrice: 0,
				currentNPrice: 0,
				priceValue: 0,
				priceType: true,
				currentTotle: 0,

				pricePool: 0,
				lable001: '价格',
				symbol: '-',
				symbol2: '-',

				t1Sort: {
					prop: 'blockSeq',
					order: 'descending', //ascending   descending
				},
				t2Sort: {
					prop: 'blockSeq',
					order: 'descending', //ascending   descending
				},


				table1: [{
						prop: 'blockSeq',
						lable: "区块"
					},
					{
						prop: 'tradeType',
						lable: "类型"
					},
					{
						prop: 'tokenAmount',
						lable: "token"
					},
					{
						prop: 'assetAmount',
						lable: "资产"
					},
					{
						prop: 'price',
						lable: "价格"
					},
					{
						prop: 'tokenBalance',
						lable: "持有"
					},
				],
				table2: [{
						prop: 'blockSeq',
						lable: "区块"
					},
					{
						prop: 'tradeType',
						lable: "类型"
					},
					{
						prop: 'tokenAmount',
						lable: "token"
					},
					{
						prop: 'assetAmount',
						lable: "资产"
					},
					{
						prop: 'price',
						lable: "价格"
					}
				],
				table3: [{
						prop: 'timestamp',
						lable: "时间"
					},
					{
						prop: 'block',
						lable: "block"
					},
					{
						prop: 'method',
						lable: "method"
					},
					{
						prop: 'value',
						lable: "参数"
					},
				],
				list1: [],
				list2: [],
				list3: [],
			}
		},

		props: {
			msg: {
				type: String,
				default: function() {
					return "========";
				}
			}
		},

		created() {
			this.host = "http://localhost/";

			if (window.config && window.config.host) {
				this.host = window.config.debug ? window.config.debughost : window.config.host;
			}

		},

		destroyed: function() {
			this.socketclose();
		},

		mounted() {
			this.initSocket();
		},

		methods: {

			switchTab(index) {
				this.viewtype = index;
			},
			setPriceType() {
				this.priceType = !this.priceType;
				let temp = {
					prop: 'price',
					lable: "价格"
				}
				this.priceValue = this.currentPrice;
				if (!this.priceType) {
					temp = {
						prop: 'priceReversed',
						lable: "价格(*)"
					}
					this.priceValue = this.currentNPrice;

				}
				this.lable001 = this.priceType ? "价格" : "价格(*)";

				this.table1[4].lable = temp.lable;
				this.table1[4].prop = temp.prop;

				this.table2[4].lable = temp.lable;
				this.table2[4].prop = temp.prop;

				this.$refs.tabelT1.inval();
				this.$refs.tabelT2.inval();



			},

			initSocket() {
				let self = this;
				const wsuri = this.host + "/ws/";
				let target = '/topic/monitor';
				let socket = new SockJS(wsuri);
				this.stompClient = Stomp.over(socket);

				this.headers = {
					Authorization: ''
				}

				let hd = this.headers;
				this.stompClient.connect(hd, () => {
					this.stompClient.subscribe(target, (msg) => {

						// console.log(msg);
						self.socketonmessage(msg.body);

					}, hd);

				}, (err) => {
					console.log('失败', err);
					this.delayReconnet(Math.random() * 3000 + 2000);
				});


				//this.stompClient.onclose
				// console.log(this.stompClient);

			},

			socketonopen() {
				console.log("WebSocket success");
			},

			socketonerror(e) {
				console.log("WebSocket error");
				console.log(e);
			},

			socketonmessage(e) {
				// console.log(e);
				// return;
				const data = JSON.parse(e);
				console.log(data);
				switch (data.eventType) {
					case "token":
						this.list2.push(data);
						this.currentPrice = data.price;
						this.currentNPrice = data.priceReversed;
						this.priceValue = this.priceType ? this.currentPrice : this.currentNPrice;
						//	this.symbol=data
						break;
					case 'trade':
						this.list1.push(data);
						if (data.tokenBalance) this.currentTotle = data.tokenBalance;
						//	this.symbol2=data
						break;
				}

			},

			socketsend(agentData) { //数据发送 
				if (!this.stompClient) return;
				let hd = this.headers;
				var target = "/app/chat.addUser";
				this.stompClient.send(target, hd,
					JSON.stringify(agentData),
				)
			},

			socketclose(e) {
				console.log("connection closed");
				if (this.stompClient) {
					this.stompClient.disconnect();
				}
			},

			delayReconnet(delay) {
				this.socketclose();
				setTimeout(() => {
					this.initSocket();
				}, delay);
			},

			sendCmd(type, value) {
				// console.log(type, value);
				let cmd = type.toLowerCase();
				let parameter = {};
				switch (cmd) {
					case 'getconfig':

						break;
					case 'getsellconfig':

						break;
					case 'saveconfig':
						parameter = value;
						break;
					case 'activeconfig':
						parameter = {
							tokenAddress: value.tokenAddress
						}
						break;
					case 'getactiveconfig':

						break;
					case 'delconfig':
						parameter = {
							tokenAddress: value.tokenAddress
						}
						break;
					case 'sellconfig':
						parameter = value;
						break;
					case 'manualsell':
						parameter = value;
						break;
					case 'sendfee':
						parameter = value;
						break;
					case 'workernum':

						break;
					case 'createworkers':

						break;
					case 'batchapprove':

						break;
					case 'manualbuy':

						break;
				}

				if (parameter.launchTime) {
					console.log(parameter.launchTime);
					if (typeof(parameter.launchTime) != 'number') parameter.launchTime = Date.parse(parameter.launchTime);
					console.log(parameter);
				}

				this.excuteCmd(this.host + type, type, parameter, this.responseCall);
			},
			excuteCmd(target, cmd, value, callback) {

				var config = {
					baseURL: this.host,
					headers: {
						'Content-Type': 'application/json;charset=utf-8'
					}
				};
				let self = this;
				// console.log(JSON.stringify(value));
				this.$axios.post(target, JSON.stringify(value), config)
					.then(function(response) {

						if (response.status == 200) {
							// callback(response.data);
							if (callback) callback(self, cmd, response.data);
						}
					})
					.catch(function(error) {
						console.log(error);
					});

			},

			responseCall(target, cmd, data) {

				if (!cmd || !data) return;

				let tempcmd = cmd.toLowerCase();

				switch (tempcmd) {
					case 'getconfig':

						this.$refs.baseConfigView.inval(data.data);
						this.$refs.nomalConfigView.inval(data.data);

						break;
					case 'getsellconfig':
						this.$refs.nomalConfigView.inval(data.data);
						break;
					case 'workernum':
						this.$refs.nomalConfigView.inval(data.data);
						break;
					case 'saveconfig':
						if (data.code.toUpperCase() == "SUCCESS") {
							this.upateConfig();
						}
						this.noti('保存提示', data.code);
						break;
					case 'activeconfig':
						this.noti('激活提示', data.code);
						break;
					case 'delconfig':
						this.upateConfig();
						this.noti('删除提示', data.code);
						break;
					case 'sellconfig':
						this.noti('修改自动卖出', data.code);
						break;
					case 'manualsell':
						this.noti('手动卖出', data.code);
						break;
					case 'sendfee':
						this.noti('发送手续费', data.code);
						break;
					case 'createworkers':
						this.noti('创建小号', data.code);
						break;
					case 'batchapprove':
						this.noti('批量授权', data.code);
						break;
					case 'manualbuy':
						this.noti('手动买入', data.code);
						break;

				}
			},

			noti(title, msg) {
				console.log(title, msg);
				if (msg.toUpperCase() == 'SUCCESS') {
					msg = "成功执行";
				}

				if (msg.toUpperCase() == 'INTERNAL_ERROR') {
					msg = "未知错误";
				}

				if (msg.toUpperCase() == 'WEB3_ERROR') {
					msg = "WEB3 链上错误";
				}

				this.$notify({
					title: title,
					message: msg
				});
			},
			upateConfig() {
				// this.$emit('submit', 'getConfig', this.form);
				this.sendCmd('getConfig', null);
			},

			changeForm(form) {
				this.symbol = form.tokenSymbol;
				this.symbol2 = form.assetSymbol;
			}
		},
	}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
	.left {
		height: 100%;
		overflow: auto;
	}

	.view-scroller {
		overflow: auto;
	}

	.toptable {
		height: 300px;
	}

	.t1 {
		height: 300px;
		overflow: hidden;
		border: 2px solid #afafaf;
		border-radius: 15px;
	}

	.view-tip {
		height: 300px;
		background-color: #dadee6;
		color: #409EFF;
	}

	.view-tip h4 {
		margin-top: 15px;
		margin-bottom: 8px;
		font-size: 22px;
	}

	.view-tip-color {
		color: #a6090b;
		font-size: 16px;
		margin: 0px;
	}

	.view-tip-color span {
		font-size: 12px;
		color: #55aaff;
	}

	.bt-sort {
		position: absolute;
		right: 10px;
		top: 10px;
		font-size: 28px;
		cursor: pointer;
	}

	.t-d {
		display: flex;
		margin-top: 5px;
		height: calc(100% - 310px);
		/* height: 100%; */
		overflow: hidden;
	}

	.t2 {
		height: 100%;
		border: 2px solid #afafaf;
		border-radius: 15px;
		padding: 5px;
		overflow: hidden;
	}

	.t3 {
		height: 100%;
		border: 2px solid #afafaf;
		border-radius: 15px;
		padding: 5px;
		overflow: hidden;
	}

	.config-view {
		/* width: 80%; */
		/* transform: translate(10%, 0); */
		/* margin-top: 20px; */

		overflow: auto;
	}

	.config-nomal {
		/* transform: translate(10%, 0);
		width: 80%; */
		/* margin-top: 20px; */
	}
</style>
