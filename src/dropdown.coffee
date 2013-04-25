

ngdd = angular.module 'ng-dropdowns', []

ngdd.directive('dropdownSelect', () ->
    return {
        restrict: 'EA'
        scope:
            selected: '='
            dropdownSelect: '='
        transclude: false
        replace: true

        controller: ($scope, $element, $attrs) ->

            $scope.active = false

            $scope.toggleActive = () ->
                $scope.active = !$scope.active

            $scope.select = (text) ->
                $scope.selected = text

            return

        template:
            "
            <div ng-click='toggleActive()' ng-class='{active:active}' class='wrap-dd-select'>
                <span class='selected'>{{selected}}</span>
                <ul class='dropdown'>
                    <li ng-repeat='item in dropdownSelect' 
                        ng-class='{divider:item.divider}'
                        ng-switch on='item.divider'>
                        <span ng-switch-when='true'></span>
                        <a ng-switch-default ng-click='select(item.text)' ng-href='{{item.href}}'>
                            <span ng-class='item.iconCls'></span>
                            {{item.text}}
                        </a>
                    </li>
                </ul>
            </div>
            "
    }               
)
.directive('dropdownMenu', () ->
    return {
        restrict: 'EA'
        scope:
            selected: '='
            dropdownSelect: '='
        transclude: false
        replace: true

        controller: ($scope, $element, $attrs) ->
            #TODO: this dropdown should use the given element as a toggle to the dropdown menu
            return

        template: ""
    }
)