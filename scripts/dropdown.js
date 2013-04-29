var ngdd;

ngdd = angular.module('ngDropdowns', []);

ngdd.directive('dropdownSelect', function($document) {
  return {
    restrict: 'A',
    scope: {
      dropdownSelect: '=',
      dropdownModel: '='
    },
    transclude: false,
    replace: true,
    controller: function($scope, $element, $attrs) {
      var body;

      $scope.select = function(text) {
        $scope.dropdownModel = text;
      };
      body = $document.find("body");
      body.bind("click", function() {
        $element.removeClass('active');
      });
      $element.bind('click', function(event) {
        event.stopPropagation();
        $element.toggleClass('active');
      });
    },
    template: "            <div class='wrap-dd-select'>                <span class='selected'>{{dropdownModel}}</span>                <ul class='dropdown'>                    <li ng-repeat='item in dropdownSelect'                         ng-class='{divider:item.divider}'                        ng-switch on='item.divider'>                        <span ng-switch-when='true'></span>                        <a ng-switch-default ng-click='select(item.text)' ng-href='{{item.href}}'>                            <span ng-class='item.iconCls'></span>                            {{item.text}}                        </a>                    </li>                </ul>            </div>            "
  };
}).directive('dropdownMenu', function($parse, $compile, $document) {
  var buildTemplate;

  buildTemplate = function(items) {
    var a, href, item, ul, _i, _len;

    ul = angular.element("<ul class='dropdown'></ul>");
    for (_i = 0, _len = items.length; _i < _len; _i++) {
      item = items[_i];
      if (item.divider) {
        ul.append("<li class='divider'></li>");
      } else if (item.text) {
        href = item.href != null ? item.href : '';
        a = angular.element("<a href='" + href + "' ng-click='select(\"" + item.text + "\")'>" + item.text + "</a>");
        if (item.iconCls != null) {
          a.prepend("<span class='" + item.iconCls + "'></span>");
        }
        ul.append(angular.element("<li></li>").append(a));
      }
    }
    return ul;
  };
  return {
    restrict: 'A',
    scope: {
      dropdownMenu: '=',
      dropdownModel: '='
    },
    controller: function($scope, $element, $attrs) {
      var body, selGetter, tpl, tplDom, wrap;

      selGetter = $parse($attrs.dropdownModel);
      $scope.dropdownModel = selGetter($scope);
      $scope.select = function(text) {
        $scope.dropdownModel = text;
      };
      tpl = buildTemplate($scope.dropdownMenu);
      tplDom = $compile(tpl)($scope);
      wrap = angular.element("<div class='wrap-dd-menu'></div>");
      $element.replaceWith(wrap);
      wrap.append($element);
      wrap.append(tplDom);
      body = $document.find("body");
      body.bind("click", function() {
        wrap.removeClass('active');
      });
      $element.bind("click", function(event) {
        event.stopPropagation();
        wrap.toggleClass('active');
      });
    }
  };
});
