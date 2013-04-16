ModulePath = require('../../lib/compiler/module/path').ModulePath
assert = require('chai').assert

describe '#parsePath', ->
    it 'should be right', ->

        ModulePath.EXTLIST = ['.js','.css']

        fakeParent = 
            config : 
                getPackage : ( name ) ->
                    return null;
                isUseLibrary : ( name ) ->

                parseLibrary : ( name ) ->

            path : 
                dirname : () ->
                    '/home/test/'

        assert.equal ModulePath.parsePath('./core.js',fakeParent) , '/home/test/core.js'
        assert.equal ModulePath.parsePath('./core',fakeParent) , '/home/test/core'
        assert.equal ModulePath.parsePath('./core/abc',fakeParent) , '/home/test/core/abc'
        assert.throws () ->
                    ModulePath.parsePath('core.js',fakeParent) 
        assert.throws () ->
                    ModulePath.parsePath('core',fakeParent)




describe '#parsePath', ->
    it 'should be right', ->

        ModulePath.EXTLIST = ['.js','.css']

        fakeParent = 
            config : 
                getPackage : ( name ) ->
                    if name is 'core' or name is 'base-js'
                        return "/home/packages/#{name}/index"
                    else 
                        return null
                isUseLibrary : ( name ) ->

                parseLibrary : ( name ) ->

            path : 
                dirname : () ->
                    '/home/test/'

        assert.equal ModulePath.parsePath('./core.js',fakeParent) , '/home/test/core.js'
        assert.equal ModulePath.parsePath('./core',fakeParent) , '/home/test/core'
        assert.throws () ->
                     ModulePath.parsePath('core-js',fakeParent) 
        assert.equal ModulePath.parsePath('core',fakeParent) , '/home/packages/core/index'
        assert.equal ModulePath.parsePath('base-js',fakeParent) , '/home/packages/base-js/index'



describe '#parsePath', ->
    it 'should be right', ->

        ModulePath.EXTLIST = ['.js','.css']

        fakeParent = 
            config : 
                getPackage : ( name ) ->
                    return null
                isUseLibrary : ( name ) ->
                    name is "core"
                parseLibrary : ( name ) ->
                    return "/home/lib/#{name}-base/"
            path : 
                dirname : () ->
                    '/home/test/'

        assert.equal ModulePath.parsePath('./core.js',fakeParent) , '/home/test/core.js'
        assert.equal ModulePath.parsePath('./core',fakeParent) , '/home/test/core'
        assert.equal ModulePath.parsePath('core/index',fakeParent) , '/home/lib/core-base/index'






