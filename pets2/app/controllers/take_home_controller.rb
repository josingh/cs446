class TakeHomeController < ApplicationController
def index(id_value)
  @adopt = Animal.id(id_value)
end
end
