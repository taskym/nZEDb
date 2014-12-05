adminApp.factory('TmuxFactory', function ($http, ajaxurl) {
	return{
		getSettings: function () {
			return $http({
				url: ajaxurl + '?action=view',
				method: 'GET'
			})
		},
		editSettings: function (data) {
			return $http.post( ajaxurl + '?action=submit', data);
		}
	}
});
		adminApp.controller("tmuxController", function ($scope, $http, TmuxFactory) {
			$scope.createTmux = false;
			TmuxFactory.getSettings().success(function (data) {
				$scope.tmuxsettings = data;
				/* Delete me */
			$scope.jumpboxSelectValue = 10;
			$('#navBar').jqxNavigationBar('expandAt', $scope.jumpboxSelectValue);
			/* End Delete */
			$scope.jumpTo = function () {
				$('#navBar').jqxNavigationBar('expandAt', $scope.jumpboxSelectValue);
			}
			$scope.navBarExpanded = function(event) {
				var expandedItem = event.args.item;
				$scope.jumpboxSelectValue = expandedItem;
			};

			$scope.backfillGroupSettings = {
				width: 150,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Choose a backfill order:",
				source: [
					{
						id: 1,
						name: 'Newest'
					},
					{
						id: 2,
						name: 'Oldest'
					},
					{
						id: 3,
						name: 'Alphabetical'

					},
					{
						id: 4,
						name: 'Alphabetical - Reverse'
					},
					{
						id: 5,
						name: 'Most Posts'
					},
					{
						id: 6,
						name: 'Fewest Posts'
					}
				]
			};
			$scope.backfillDaysSettings = {
				width: 150,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Choose a backfill order:",
				source: [
					{
						id: 1,
						name: 'Days Per Group'
					},
					{
						id: 2,
						name: 'Safe Backfill day'
					}
				]
			};
			$scope.backfillSettings = {
				width: 150,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Enable/Disable Backfill..:",
				source: [
					{
						id: 0,
						name: 'Disabled'
					},
					{
						id: 4,
						name: 'Safe'
					},
					{
						id: 2,
						name: 'Group'
					},
					{
						id: 1,
						name: 'All'
					}
				]
			};
			$scope.updateBinariesSettings = {
				width: 180,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Enable/Disable Update Binaries",
				source: [
					{
						id: 0,
						name: 'Disabled'
					},
					{
						id: 1,
						name: 'Simple Threaded Update'
					},
					{
						id: 2,
						name: 'Complete Threaded Update'

					}
				]
			};
			$scope.sequentialSettings = {
				width: 180,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Enable/Disable Sequential",
				source: [
					{
						id: 0,
						name: 'Disabled'
					},
					{
						id: 1,
						name: 'Basic Sequential'
					},
					{
						id: 2,
						name: 'Complete Sequential'

					}
				]
			};
			$scope.importSettings = {
				width: 240,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Enable/Disable Import",
				source: [
					{
						id: 0,
						name: 'Disabled'
					},
					{
						id: 1,
						name: 'Import - Do Not Use Filenames'
					},
					{
						id: 2,
						name: 'Import - Use Filenames'

					}
				]
			};
			$scope.releasesSettings = {
				width: 240,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Enable/Disable Update Releases",
				source: [
					{
						id: 0,
						name: 'Disabled'
					},
					{
						id: 1,
						name: 'Update Releases'
					},
					{
						id: 2,
						name: 'Update Releases Threaded'

					}
				]
			};
			$scope.postSettings = {
				width: 240,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Enable/Disable Post Processing",
				source: [
					{
						id: 0,
						name: 'Disabled'
					},
					{
						id: 1,
						name: 'PostProcess Additional'
					},
					{
						id: 2,
						name: 'PostProcess NFOs'

					},
					{
						id: 3,
						name: 'All'
					}
				]
			};
			$scope.postnonSettings = {
				width: 240,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Enable/Disable Process Amazon Lookups",
				source: [
					{
						id: 0,
						name: 'Disabled'
					},
					{
						id: 1,
						name: 'All Available Releases'
					},
					{
						id: 2,
						name: 'Properly Renamed Releases'

					}
				]
			};
			$scope.dehashSettings = {
				width: 180,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Enable/Disable Decrypt Hashes",
				source: [
					{
						id: 0,
						name: 'Disabled'
					},
					{
						id: 1,
						name: 'Decrypt Hashes'
					},
					{
						id: 2,
						name: 'Predb'

					},
					{
						id: 3,
						name: 'All'
					}
				]
			};
			$scope.fixcrapSettings = {
				width: 180,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Enable/Disable Decrypt Hashes",
				source: [
					{
						id: 0,
						name: 'Disabled'
					},
					{
						id: 1,
						name: 'Decrypt Hashes'
					},
					{
						id: 2,
						name: 'Predb'

					},
					{
						id: 3,
						name: 'All'
					}
				]
			};

			$scope.fixreleasesDisabled = false;
			 if($scope.tmuxsettings.fix_crap_opt == "Custom") {
			 $scope.fixCrapDisabled = false;
			 }else{
			 $scope.fixCrapDisabled = true;
			 }
			 $scope.enableCrapCheckboxes = function () {
			if($scope.tmuxsettings.fix_crap_opt == "Custom"){
			 $scope.fixCrapDisabled = false;
			}else{
				$scope.fixCrapDisabled = true;
			}
			 };

			$scope.fixCrapNames = [
				{
					name: 'blacklist'
				},
				{
					name: 'blfiles'
				},
				{
					name: 'executable'
				},
				{
					name: 'gibberish'
				},
				{
					name: 'hashed'
				},
				{
					name: 'installbin'
				},
				{
					name: 'passworded'
				},
				{
					name: 'passwordurl'
				},
				{
					name: 'sample'
				},
				{
					name: 'scr'
				},
				{
					name: 'short'
				},
				{
					name: 'size'
				},
				{
					name: 'huge'
				},
				{
					name: 'codec'
				}
			];

			$scope.jumpboxSettings = {
				width: 240,
				height: 30,
				autoDropDownHeight: true,
				displayMember: "name",
				valueMember: "id",
				placeHolder: "Quick Jump...",
				source: [
					{
						id: 0,
						name: 'Tmux - how it works'
					},
					{
						id: 4,
						name: 'Backfill'
					},
					{
						id: 8,
						name: 'Comment Sharing'
					},
					{
						id: 11,
						name: 'Decrypt Hashes'
					},
					{
						id: 9,
						name: 'Fix Release Names'
					},
					{
						id: 5,
						name: 'Import Nzbs'
					},
					{
						id: 14,
						name: 'Miscellaneous'
					},
					{
						id: 1,
						name: 'Monitor'
					},
					{
						id: 7,
						name: 'Postprocessing'
					},
					{
						id: 13,
						name: 'PreDb IRC Scraper'
					},
					{
						id: 10,
						name: 'Remove Crap Releases'
					},
					{
						id: 2,
						name: 'Sequential'
					},
					{
						id: 15,
						name: 'Server Monitors'
					},
					{
						id: 3,
						name: 'Update Binaries'
					},
					{
						id: 6,
						name: 'Update Releases'
					},
					{
						id: 12,
						name: 'Update TV/Theater'
					}
				]
			};
			$scope.saveButtonSettings = {
					width: 150,
					height: 30
				};
			$scope.saveTmux = function (tmuxsettings) {
				var data = angular.toJson(angular.copy(tmuxsettings));
				TmuxFactory.editSettings(data).success(function (data) {
					console.log(data);
				}).
						error(function (data, status, headers, config) {
							alert(data);
						});
			};
			$scope.createTmux = true;

			});
		});
