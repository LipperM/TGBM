<template>

	<div ref="tableView" class="table-content">
		<div class="log-title layout-center">{{title}}</div>
		<el-table size="mini" :data="dataList" :height="height" :default-sort="sort" stripe style="width: 100%"
			class="log-table">

			<el-table-column :formatter="tableformat" align='center' :sortable='true' v-for="(item,index) in files"
				:label="item.lable" :prop="item.prop">

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
			sort: {
				type: Object,
				default: function() {
					return this.defsort;
				}
			},
			files: {
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

			setTimeValue(value) {
				return this.FomatTime(value);
			},

			tableformat(row, column, cellValue, index) {
				let prop = column.property;
				const daterc = row[prop];

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
</style>
