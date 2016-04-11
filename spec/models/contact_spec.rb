require "rails_helper"

describe Contact do 
  # 姓と命とメールがあれば有効な状態であること
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: "Aaron",
      lastname: "Sumner",
      email: "tester@example.com")
    expect(contact).to be_valid
  end

  # 名が無ければ無効な状態であること
  it "is invalid without a firstname" do
    contact = Contact.new(firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end
  # 姓が無ければ無効な状態であること
  it "is invalid without a lastname" do
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end
  # メールアドレスが無ければ無効な状態であること
  it "is invalid without an email address" do 
  end
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplivate email address" do
    Contact.create( 
      firstname: "Joe", lastname: "Tester",
      email: "tester@example.com"
    ) 
    contact = Contact.new( 
      firstname: "Joe", lastname: "Tester",
      email: "tester@example.com"
    )
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end
 
  # 連絡先のフルネームを文字列として返すこと 
  it "reurns a contact's full name as a string" do 
    contact = Contact.new(firstname: "John", lastname: "Doe", 
      email: "johndoe@example.com")
    expect(contact.name).to eq "John Doe"
  end
end
