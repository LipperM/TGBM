<template>
	<div id="app">

		<MainView></MainView>
	</div>
</template>

<script>
	import MainView from './components/main-view.vue'


	export default {
		name: 'app',
		components: {
			MainView
		},
		created() {
			// this.loadConfig();
		},
		methods: {
			loadConfig() {
				this.$axios.get('./public/static/config.json').then(res => {
					console.log(res);
				}).catch(function(error) {
					console.log(error);
				});
			}
		}
	}
</script>

<style>
	html,
	body {
		width: 100%;
		height: 100%;
		margin: 0;
		padding: 0;
		overflow: hidden;
	}

	#app {
		font-family: 'Avenir', Helvetica, Arial, sans-serif;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
		text-align: center;
		color: #000000;
		height: 100%;
		overflow: hidden;
	}

	.content {}


	.layout-center {
		text-align: center;
		display: -webkit-box;
		display: -ms-flexbox;
		display: -webkit-flex;
		display: flex;
		flex-direction: column;
		-webkit-box-pack: center;
		-ms-flex-pack: center;
		-webkit-justify-content: center;
		justify-content: center;
		-webkit-box-align: center;
		-ms-flex-align: center;
		-webkit-align-items: center;
		align-items: center;
	}


	.layout-center-row {
		text-align: center;
		display: -webkit-box;
		display: -ms-flexbox;
		display: -webkit-flex;
		display: flex;
		flex-direction: row;
		-webkit-box-pack: center;
		-ms-flex-pack: center;
		-webkit-justify-content: center;
		justify-content: center;
		-webkit-box-align: center;
		-ms-flex-align: center;
		-webkit-align-items: center;
		align-items: center;
	}

	.layout-left {
		text-align: left;
		display: -webkit-box;
		display: -ms-flexbox;
		display: -webkit-flex;
		display: flex;
		flex-direction: row;
		-webkit-box-pack: start;
		-ms-flex-pack: start;
		-webkit-justify-content: flex-start;
		justify-content: flex-start;
		-webkit-box-align: center;
		-ms-flex-align: center;
		-webkit-align-items: flex-start;
		align-items: center;
	}

	.layout-left * {
		vertical-align: middle !important;
	}

	.padding-0 {
		padding: 0px !important;
	}

	.padding-8 {
		padding: 8px !important;
	}

	.margin-0 {
		margin: 0px !important;
	}

	.margin-8 {
		margin: 8px !important;
	}

	.margin-l-8 {
		margin-left: 8px !important;
	}


	.full {
		width: 100% !important;
		height: 100% !important;
	}

	.full-h {
		height: 100% !important;
	}
</style>
