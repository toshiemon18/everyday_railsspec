require "rails_helper"

describe Contact do

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryGirl.build(:contact)).to be_valid
  end

  # 姓と名とメールがあれば有効な状態であること
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: "Aaron",
      lastname: "Sumner",
      email: "tester@example.com")
    expect(contact).to be_valid
  end

  # 名が無ければ無効な状態であること
  it "is invalid without a firstname" do
    contact = FactoryGirl.build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  # 姓が無ければ無効な状態であること
  it "is invalid without a lastname" do
      contact = FactoryGirl.build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  # メールアドレスが無ければ無効な状態であること
  it "is invalid without an email address" do
    contact = FactoryGirl.build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end
    
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplivate email address" do
    FactoryGirl.create(:contact, email: "aaron@example.com")
    contact = FactoryGirl.build(:contact, email: "aaron@example.com")
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end
 
  # 連絡先のフルネームを文字列として返すこと 
  it "reurns a contact's full name as a string" do
    contact = FactoryGirl.build(:contact, 
        firstname: "Jane",
        lastname: "Smith"
    )
    expect(contact.name).to eq "Jane Smith"
  end

  # 文字で姓をフィルタする
  describe "filter last name by letter" do 
    before :each do 
      @smith = Contact.create( 
        firstname: "John", lastname: "Smith",
        email: "jsmith@example.com"
      )

      @jones = Contact.create(
        firstname: "Tim", lastname: "Jones",
        email: "tjones@example.com"
      )

      @johnson = Contact.create(
        firstname: "John", lastname: "Johnson",
        email: "jjohnson@example.com"
      )
    end

    # マッチする文字の場合
    context "matching letters" do 
      #マッチした結果をソート済みの配列として返すこと
      it "returns a sorted array of results that match" do 
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    # マッチしない文字の場合
    context "non-matching letters" do 
      # マッチしなかったものは結果に含まれないこと
      it "omits results that do not match" do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end
  end
  
  # 3つの電話番号を持つこと
  it "has three phone numbers" do 
    expect(create(:contact).phones.count).to eq 3
  end

end
