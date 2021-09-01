class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user || record.master.user == user
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    record.user == user
  end

  def cancel?
    record.user == user
  end

  def accept?
    record.master.user == user
  end

  def reject?
    record.master.user == user
  end

  def pay?
    record.user == user
  end

  def done?
    record.user == user
  end
end
