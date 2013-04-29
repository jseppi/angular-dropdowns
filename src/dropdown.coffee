#TODOS:
# - styling for divider li elements

ngdd = angular.module 'ngDropdowns', []

ngdd.directive('dropdownSelect', ($document) ->
    return {
        restrict: 'A'
        scope:
            dropdownSelect: '='
            dropdownModel: '='
            
        transclude: false
        replace: true

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
            dropdownModel: '='

        controller: ($scope, $element, $attrs) ->

            selGetter = $parse($attrs.dropdownModel)
            $scope.dropdownModel = selGetter($scope)
            
            $scope.select = (text) ->
                $scope.dropdownModel = text
                return

            tpl = buildTemplate($scope.dropdownMenu)
            tplDom = $compile(tpl)($scope)
            wrap = angular.element("<div class='wrap-dd-menu'></div>")
            $element.replaceWith(wrap)
            wrap.append($element)
            wrap.append(tplDom)

            body = $document.find("body")
            body.bind("click", () ->
                wrap.removeClass('active')
                return
            )

            $element.bind("click", (event) ->
                event.stopPropagation()
                wrap.toggleClass('active')
                return
            )

            return


    }
)