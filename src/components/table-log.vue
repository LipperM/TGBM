<template>

	<div ref="tableView" class="table-content">
		<div class="log-title layout-center">{{title}}</div>
		<el-table size="mini" :data="dataList" :height="height" :default-sort="sort" stripe style="width: 100%"
			class="log-table">

			<el-table-column :row-key="mkey" :formatter="tableformat" align='center' :sortable='true'
				v-for="(item,index) in fields" :label="item.lable" :prop="item.prop">
				<!-- 
				<template slot-scope='scope'>
					<span>{{scope.row.data}}</span>
				</template> -->

				<template slot-scope="scope">

					<el-popover v-show="item.prop=='blockSeq'" trigger="hover" placement="top">
						<p>{{ setTimeValue(scope.row.timestamp) }}</p>
						<div slot="reference" class="name-wrapper">
							<el-tag :class="item.prop" @click="gourl(scope.row.txHash,item.prop)" size="medium">
								{{scope.row[item.prop]}}
							</el-tag>
						</div>
					</el-popover>

					<!-- <p v-show="item.prop != 'blockSeq'">{{setFormat(scope.row[item.prop],item.prop)}}</p> -->
					<div :class="item.prop" @click="gourl(scope.row.txHash,item.prop)"
						v-html="setFormat(scope.row[item.prop],item.prop)">
					</div>
				</template>

			</el-table-column>

		</el-table>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				height: 0,
				defsort: {
					prop: 'timestamp',
					order: 'descending', //ascending   descending
				},

			}
		},
		props: {
			title: {
				type: String,
				default: function() {
					return "这是表格";
				}
			},
			mkey: {
				type: String,
				default: function() {
					return "blockSeq";
				}
			},
			sort: {
				type: Object,
				default: function() {
					return this.defsort;
				}
			},
			fields: {
				type: Array,
				default: function() {
					return [{
							prop: 'date',
							lable: "日期"
						},
						{
							prop: 'name',
							lable: "姓名"
						},
						{
							prop: 'address',
							lable: '地址'
						}
					];
				}
			},

			dataList: {
				type: Array,
				default: function() {
					return [];
				}
			}
		},
		created() {

		},
		mounted() {
			this.$nextTick(() => { // 页面渲染完成后的回调
				this.height = this.$refs.tableView.offsetHeight - 50;
				this.$refs.tableView.height = this.height;
			})
		},
		methods: {

			inval() {
				this.$forceUpdate();
			},

			gourl(index, prop) {
				if (index == null) return;

				if (prop == "txHash" || prop == 'blockSeq') {
					let url = 'https://bscscan.com/tx/{0}'.replace("{0}", index);
					window.open(url, '_blank');
				}

			},

			setFormat(value, prop) {
				if (value == 'buy') return "购买";
				if (value == 'sell') return "出售";

				if (prop == "txHash") return this.sublen(value, 0, 10);

				if (prop == 'timestamp') return this.FomatTime(value);
				value = String(value).replace(/,/g, "<br>");
				return value;
				//	return typeof value == 'object' ? JSON.stringify(value) : value;
			},

			setTimeValue(value) {
				return this.FomatTime(value);
			},

			tableformat(row, column, cellValue, index) {
				let prop = column.property;
				const daterc = row[prop];

				if (daterc != null) {
					// const dateMat = new Date(parseInt(daterc.replace("/Date(", "").replace(")/", ""), 10));
					// const year = dateMat.getFullYear();
					// const month = dateMat.getMonth() + 1;
					// const day = dateMat.getDate();
					// const hh = dateMat.getHours();
					// const mm = dateMat.getMinutes();
					// const ss = dateMat.getSeconds();
					// const timeFormat = year + "/" + month + "/" + day + " " + hh + ":" + mm + ":" + ss;
					// return timeFormat;

				}

				if (daterc == 'buy') return "购买";
				if (daterc == 'sell') return "出售";
				if (prop == 'timestamp') return this.FomatTime(daterc);


				return daterc;
			}

		},


	}
</script>

<style scoped="scoped">
	.table-content {
		margin: 5px;
		height: 100%;
	}

	.log-table {
		width: 100% !important;
		overflow-y: hidden;
	}

	.el-table__body {
		overflow-y: scroll !important;
	}

	.log-title {
		height: 40px;
		text-align: center;
		color: #409EFF;
		font-size: 24px;
		font-weight: bold;
	}

	.txHash {
		cursor: pointer;
	}

	.txHash :hover {
		color: #006DCC !important;
	}

	.blockSeq {
		cursor: pointer;
	}

	.blockSeq :hover {
		color: #006DCC !important;
	}
</style>
