#TODOS:
# - styling for divider li elements

ngdd = angular.module 'ngDropdowns', []

ngdd.directive('dropdownSelect', ($document) ->
    return {
        restrict: 'A'
        replace: true
        scope:
            dropdownSelect: '='
            dropdownModel: '='
        

        controller: ($scope, $element, $attrs) ->

            $scope.select = (text) ->
                $scope.dropdownModel = text
                return

            body = $document.find("body")
            body.bind("click", () ->
                $element.removeClass('active')
                return
            )

            $element.bind('click', (event) ->
                event.stopPropagation()
                $element.toggleClass('active')
                return
            )

            return

        template:
            "
            <div class='wrap-dd-select'>
                <span class='selected'>{{dropdownModel}}</span>
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
.directive('dropdownMenu', ($parse, $compile, $document) ->
    
    template = """
        <ul class='dropdown'>
            <li ng-repeat='item in dropdownMenu'
                ng-class='{divider:item.divider}'
                ng-switch on='item.divider'>
                <span ng-switch-when='true'></span>
                <a ng-switch-default ng-click='select(item.text)' ng-href='{{item.href}}'>
                    <span ng-class='item.iconCls'></span>
                    {{item.text}}
                </a>
            </li>
        </ul>
        """

    return {
        restrict: 'A'
        replace: false
        scope:
            dropdownMenu: '='
            dropdownModel: '='

        controller: ($scope, $element, $attrs, $transclude) ->

            selGetter = $parse($attrs.dropdownModel)
            $scope.dropdownModel = selGetter($scope)

            tpl = $compile(template)($scope)

            $wrap = angular.element("<div class='wrap-dd-menu'></div>")
            
            $element.replaceWith($wrap)

            $wrap.append($element)
            $wrap.append(tpl)

            $scope.select = (text) ->
                $scope.dropdownModel = text
                return

            body = $document.find("body")
            body.bind("click", () ->
                tpl.removeClass('active')
                return
            )

            $element.bind("click", (event) ->
                event.stopPropagation()
                tpl.toggleClass('active')
                return
            )

            return


    }
)