angular.module('ngDropdowns', [])
.directive('dropdownSelect', ['DropdownService', (DropdownService) ->
    return {
        restrict: 'A'
        replace: true
        scope:
            dropdownSelect: '='
            dropdownModel: '='
            dropdownOnchange: '&'

        controller: ['$scope', '$element', '$attrs', ($scope, $element, $attrs) ->

            $scope.labelField = if $attrs.dropdownItemLabel? then $attrs.dropdownItemLabel else 'text'

            DropdownService.register($element)

            this.select = (selected) ->
                if selected != $scope.dropdownModel
                    angular.copy(selected, $scope.dropdownModel)
                $scope.dropdownOnchange({ selected: selected })
                return

            $element.bind('click', (event) ->
                event.stopPropagation()
                DropdownService.toggleActive($element)
                return
            )

            $scope.$on('$destroy', () ->
                DropdownService.unregister($element)
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
                        class='dropdown-item'
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
.directive('dropdownMenu', ['$parse', '$compile', 'DropdownService', ($parse, $compile, DropdownService) ->

    template = """
        <ul class='dropdown'>
            <li ng-repeat='item in dropdownMenu'
                class='dropdown-item'
                dropdown-item-label='labelField'
                dropdown-menu-item='item'>
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

            DropdownService.register(tpl)

            this.select = (selected) ->
                if selected != $scope.dropdownModel
                    angular.copy(selected, $scope.dropdownModel)
                $scope.dropdownOnchange({ selected: selected })
                return

            $element.bind("click", (event) ->
                event.stopPropagation()
                DropdownService.toggleActive(tpl)
                return
            )

            $scope.$on('$destroy', () ->
                DropdownService.unregister(tpl)
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
.factory('DropdownService', ['$document', ($document) ->
    service = {}

    _dropdowns = []

    body = $document.find('body')
    body.bind('click', () ->
        angular.forEach(_dropdowns, (el) ->
            el.removeClass('active')
            return
        )
    )

    service.register = (ddEl) ->
        _dropdowns.push ddEl
        return

    service.unregister = (ddEl) ->
        index = _dropdowns.indexOf(ddEl)
        _dropdowns.splice(index, -1) if index > -1
        return

    service.toggleActive = (ddEl) ->
        angular.forEach(_dropdowns, (el) ->
            el.removeClass('active') if el isnt ddEl
            return
        )
        ddEl.toggleClass('active')
        return

    return service
])
