

ngdd = angular.module 'ng-dropdowns', []


ngdd.directive('dropdownSelect', ($parse, $timeout, $compile) ->
    
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


            #dropdown = angular.element buildTemplate(items, selected)

            # elm.append(dropdown)

            # scope.selectItem = (txt) ->
            #     console.log "selected #{txt}", arguments
            #     return            

            # $compile(dropdown)(scope)

            # wrapper = angular.element(elm.children()[0])

            # wrapper.bind('click', () ->
            #     wrapper.toggleClass('active')
            #     return false
            # )

            # ul = wrapper.find('ul')
            # lis = ul.children()
            # angular.forEach(lis, (li) ->
            #     li = angular.element(li)
            #     if li.hasClass('divider') then return
            #     li.bind('click', () ->
            #         selGetter.assign(scope, li.text())
            #         scope.$digest()
            #         #scope.$apply()
            #         return
            #     )
            #     return               
            # )

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
                        <a ng-switch-default href=''><span>{{item.text}}</span></a>
                    </li>
                </ul>
            </div>
            "
    }               
)