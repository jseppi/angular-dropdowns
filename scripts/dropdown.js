var ngdd;

ngdd = angular.module('ng-dropdowns', []);

ngdd.directive('dropdownSelect', function($parse, $timeout, $compile) {
  return {
    restrict: 'EA',
    scope: {
      selected: '=',
      dropdownSelect: '='
    },
    transclude: false,
    replace: true,
    controller: function($scope, $element, $attrs) {
      $scope.active = false;
      $scope.toggleActive = function() {
        return $scope.active = !$scope.active;
      };
    },
    template: "            <div ng-click='toggleActive()' ng-class='{active:active}' class='wrap-dd-select'>                <span class='selected'>{{selected}}</span>                <ul class='dropdown'>                    <li ng-repeat='item in dropdownSelect'                         ng-class='{divider:item.divider}'                        ng-switch on='item.divider'>                        <span ng-switch-when='true'></span>                        <a ng-switch-default href=''><span>{{item.text}}</span></a>                    </li>                </ul>            </div>            "
  };
});
