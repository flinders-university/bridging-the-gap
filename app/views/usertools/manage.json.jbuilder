json.array!(@Users) do |user|
  json.extract! user, :id, :firstname, :lastname, :email, :group_id, :age, :gender, :degree, :major
end
