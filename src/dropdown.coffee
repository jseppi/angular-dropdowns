
ngdd = angular.module 'ngDropdowns', []

ngdd.directive('dropdownSelect', ($document) ->
    return {
        restrict: 'A'
        replace: true
        scope:
            dropdownSelect: '=' # Must have a .text attribute
            dropdownModel: '='
        

        controller: ($scope, $element, $attrs) ->

            this.select = (selected) ->
                angular.copy(selected, $scope.dropdownModel)
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
            """
            <div class='wrap-dd-select'>
                <span class='selected'>{{dropdownModel.text}}</span>
                <ul class='dropdown'>
                    <li ng-repeat='item in dropdownSelect'
                        dropdown-select-item='item'>
                    </li>
                </ul>
            </div>
            """
    }               
)
.directive('dropdownSelectItem', () ->
    return {
        require: '^dropdownSelect'
        replace: true
        scope:
            dropdownSelectItem: '='
        link: (scope, element, attrs, dropdownSelectCtrl) ->
            scope.selectItem = () ->
                return if scope.dropdownSelectItem.href
                dropdownSelectCtrl.select scope.dropdownSelectItem
                return

            return
        
        template: """
            <li ng-class='{divider: dropdownSelectItem.divider}'>
                <a href='' 
                    ng-if='!dropdownSelectItem.divider' 
                    ng-href='{{dropdownSelectItem.href}}'
                    ng-click='selectItem()'>
                    {{dropdownSelectItem.text}}
                </a>
            </li>"""
    }

)
.directive('dropdownMenu', ($parse, $compile, $document) ->
    
    template = """
        <ul class='dropdown'>
            <li ng-repeat='item in dropdownMenu'
                dropdown-menu-item='item'></li>
            </li>
        </ul>
        """

    return {
        restrict: 'A'
        replace: false
        scope:
            dropdownMenu: '='
            dropdownModel: '='

        controller: ($scope, $element, $attrs) ->

            $template = angular.element(template)

            #Attach this controller to the element's data
            $template.data('$dropdownMenuController', this)

            tpl = $compile($template)($scope)

            $wrap = angular.element("<div class='wrap-dd-menu'></div>")
            
            $element.replaceWith($wrap)

            $wrap.append($element)
            $wrap.append(tpl)

            this.select = (selected) ->
                angular.copy(selected, $scope.dropdownModel)
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
.directive('dropdownMenuItem', () ->
    return {
        require: '^dropdownMenu'
        replace: true
        scope:
            dropdownMenuItem: '='
        link: (scope, element, attrs, dropdownMenuCtrl) ->

            scope.selectItem = () ->
                return if scope.dropdownMenuItem.href
                dropdownMenuCtrl.select scope.dropdownMenuItem
                return

            return
        
        template: """
            <li ng-class='{divider: dropdownMenuItem.divider}'>
                <a href='' 
                    ng-if='!dropdownMenuItem.divider' 
                    ng-href='{{dropdownMenuItem.href}}'
                    ng-click='selectItem()'>
                    {{dropdownMenuItem.text}}
                </a>
            </li>"""
    }

)