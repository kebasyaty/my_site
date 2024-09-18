require "./spec_helper"

describe MySite do
  it "works" do
    client : Mongo::Client = Mongo::Client.new
    database_name = "test_pcSenRPaSdaU2IjZ"
    collection_name = "test_collection_name"
    database = client[database_name]
    collection = database[collection_name]
    collection.insert_one({one: 1})
    filter = BSON.new
    tmp_doc = Array(BSON).new
    tmp_doc << BSON.new({"one" => 1})
    filter["$or"] = tmp_doc
    bson = collection.find_one(filter)
    bson.not_nil!["one"].should eq(1)
    client.close
  end
end
