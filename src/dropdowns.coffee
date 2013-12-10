angular.module('ngDropdowns', [])
.directive('dropdownSelect', ['$document', ($document) ->
    return {
        restrict: 'A'
        replace: true
        scope:
            dropdownSelect: '='
            dropdownModel: '='
            dropdownOnchange: '&'

        controller: ['$scope', '$element', '$attrs', ($scope, $element, $attrs) ->

            $scope.labelField = if $attrs.dropdownItemLabel? then $attrs.dropdownItemLabel else 'text'

            this.select = (selected) ->
                angular.copy(selected, $scope.dropdownModel)
                $scope.dropdownOnchange({ selected: selected })
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
        ]

        template:
            """
            <div class='wrap-dd-select'>
                <span class='selected'>{{dropdownModel[labelField]}}</span>
                <ul class='dropdown'>
                    <li ng-repeat='item in dropdownSelect'
                        dropdown-select-item='item'
                        dropdown-item-label='labelField'>
                    </li>
                </ul>
            </div>
            """
    }
])
.directive('dropdownSelectItem', [() ->
    return {
        require: '^dropdownSelect'
        replace: true
        scope:
            dropdownItemLabel: '='
            dropdownSelectItem: '='

        link: (scope, element, attrs, dropdownSelectCtrl) ->

            scope.selectItem = () ->
                return if scope.dropdownSelectItem.href
                dropdownSelectCtrl.select scope.dropdownSelectItem
                return

            return

        template: """
            <li ng-class='{divider: dropdownSelectItem.divider}'>
                <a href='' class='dropdown-item'
                    ng-if='!dropdownSelectItem.divider'
                    ng-href='{{dropdownSelectItem.href}}'
                    ng-click='selectItem()'>
                    {{dropdownSelectItem[dropdownItemLabel]}}
                </a>
            </li>"""
    }

])
.directive('dropdownMenu', ['$parse', '$compile', '$document', ($parse, $compile, $document) ->

    template = """
        <ul class='dropdown'>
            <li ng-repeat='item in dropdownMenu'
                dropdown-item-label='labelField'
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
            dropdownOnchange: '&'

        controller: ['$scope', '$element', '$attrs', ($scope, $element, $attrs) ->

            $scope.labelField = if $attrs.dropdownItemLabel? then $attrs.dropdownItemLabel else 'text'

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
                $scope.dropdownOnchange({ selected: selected })
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
        ]
    }
])
.directive('dropdownMenuItem', [() ->
    return {
        require: '^dropdownMenu'
        replace: true
        scope:
            dropdownMenuItem: '='
            dropdownItemLabel: '='

        link: (scope, element, attrs, dropdownMenuCtrl) ->

            scope.selectItem = () ->
                return if scope.dropdownMenuItem.href
                dropdownMenuCtrl.select scope.dropdownMenuItem
                return

            return

        template: """
            <li ng-class='{divider: dropdownMenuItem.divider}'>
                <a href='' class='dropdown-item'
                    ng-if='!dropdownMenuItem.divider'
                    ng-href='{{dropdownMenuItem.href}}'
                    ng-click='selectItem()'>
                    {{dropdownMenuItem[dropdownItemLabel]}}
                </a>
            </li>"""
    }

])
