class DemoController < ApplicationController

    layout "application"

    def index
        render('index')
    end

    def hello
        @array = [1,2,3,4,5]  #instance variable has leading @, reg var does not, reg var only accessible inside this class
        @id = params['id']  #either string or :hash will work
        @page = params[:page]
        render('hello')
    end

    def other_hello
        redirect_to(:action => 'index') #list controller before action if in different directory :controller => 'nameOfController'
    end

    def lynda
        redirect_to('http://www.lynda.com')
    end

    def escape_output

    end
end
