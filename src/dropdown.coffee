

ngdd = angular.module 'ngDropdowns', []

ngdd.directive('dropdownSelect', () ->
    return {
        restrict: 'EA'
        scope:
            dropdownSelect: '='
            ddSelected: '='
            
        transclude: false
        replace: true

        controller: ($scope, $element, $attrs) ->

            $scope.active = false

            $scope.toggleActive = () ->
                $scope.active = !$scope.active

            $scope.select = (text) ->
                $scope.ddSelected = text

            return

        template:
            "
            <div ng-click='toggleActive()' ng-class='{active:active}' class='wrap-dd-select'>
                <span class='selected'>{{ddSelected}}</span>
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
.directive('dropdownMenu', ($parse, $compile) ->
    
    buildTemplate = (items) ->
        ul = angular.element("<ul class='dropdown'></ul>")
        
        for item in items
            if item.divider then ul.append("<li class='divider'></li>")
            else if item.text 
                href = if item.href? then item.href else ''
                a = angular.element(
                    "<a href='#{href}' ng-click='select(\"#{item.text}\")'>#{item.text}</a>"
                )
                a.prepend("<span class='#{item.iconCls}'></span>") if item.iconCls?
                ul.append(angular.element("<li></li>").append(a))

        return ul

    return {
        restrict: 'A'
        scope:
            dropdownMenu: '='
            ddSelected: '='

        controller: ($scope, $element, $attrs) ->

            selGetter = $parse($attrs.ddSelected)
            $scope.ddSelected = selGetter($scope)
            
            $scope.select = (text) ->
                $scope.ddSelected = text
                return

            tpl = buildTemplate($scope.dropdownMenu)
            tplDom = $compile(tpl)($scope)
            wrap = angular.element("<div class='wrap-dd-menu'></div>")
            $element.wrap(wrap)
            wrap.append(tplDom)

            $element.bind("click", () ->
                $element.parent().toggleClass('active')
                return
            )

            return


    }
)