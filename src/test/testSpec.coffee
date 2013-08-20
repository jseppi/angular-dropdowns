describe 'dropdowns', () ->

    $compile = $rootScope = null
    
    expect = chai.expect
    should = chai.should()

    beforeEach(module('ngDropdowns'))

    beforeEach(inject((_$compile_, _$rootScope_) ->
        $compile = _$compile_
        $rootScope = _$rootScope_

        opts = [
            {
                text: 'Option1'
                value: 'one'
                iconCls: 'someicon'
            }
            {
                text: 'Option2'
                someprop: 'somevalue'
            }
            {
                divider: true
            }  
            {
                text: 'Option4'
                href: 'http://www.google.com'
            }                   
        ]  

        $rootScope.selectOptions = opts
        $rootScope.selected = {}

        return
    ))

    describe "dropdown select", () ->

        it 'should create a dropdown select', () ->
            html = '<div dropdown-select="selectOptions" dropdown-model="selected"></div>'

            element = $compile(html)($rootScope)

            expect(element).to.be
            return

    describe "dropdown menu", () ->

        it 'should create a dropdown menu', () ->
            html = '<div><div dropdown-menu="selectOptions" dropdown-model="selected"></div></div>'
            
            element = $compile(html)($rootScope)

            expect(element).to.be
            return