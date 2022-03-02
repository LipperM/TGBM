<template>
	<el-tabs v-model="activeName" type="card" @tab-click="handleClick">
		<el-tab-pane label="基本配置" name="base"></el-tab-pane>
		<el-tab-pane label="卖出配置" name="nomal"></el-tab-pane>
	</el-tabs>
</template>

<script>
	export default {
		data() {
			return {
				activeName: 'base'
			};
		},
		methods: {
			handleClick(tab, event) {
				this.$emit('click', tab.index);
			}
		}
	};
</script>

<style>
	.top-conent {
		border-bottom: 1px solid #4a4a4a;
	}

	.el-tag {
		margin-left: 10px;
		cursor: pointer;
	}

	.button-new-tag {
		margin-left: 10px !important;
		height: 32px;
		line-height: 30px;
		padding-top: 0;
		padding-bottom: 0;
	}

	.input-new-tag {
		width: 90px;
		margin-left: 10px;
		vertical-align: bottom;
	}

	.is-top {
		margin-bottom: 0px !important;
	}
</style>
