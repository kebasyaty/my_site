require "./spec_helper"

describe MySite do
  it "works" do
    client : Mongo::Client = Mongo::Client.new
    database_name = "test_pcSenRPaSdaU6IjZ"
    collection_name = "test_collection_name"
    database = client[database_name]
    collection = database[collection_name]
    collection.insert_one({"field_name_1" => [1, 2, 3]})
    filter = BSON.new
    tmp_doc = Array(BSON).new
    tmp_doc << BSON.new({"field_name_1" => {"$all" => [1, 2, 3]}})
    filter["$and"] = tmp_doc
    bson = collection.find_one(filter)
    bson.not_nil!.to_h["field_name_1"].should eq([1, 2, 3])
    client.close
  end
end
