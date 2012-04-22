require "spec_helper"
require "lego_nxt/types"

shared_examples_for "a type" do |minimum, maximum, pack_char|
  random_int = minimum + rand(maximum - minimum)
  subject { described_class.new random_int }

  describe "#new" do
    it "accepts the minimum: #{minimum}" do
      described_class.new(minimum)
    end

    it "refuses #{minimum - 1}" do
      expect { described_class.new(minimum - 1) }.to raise_error(ArgumentError)
    end

    it "accepts the maximum: #{maximum}" do
      described_class.new(maximum)
    end

    it "refuses #{maximum + 1}" do
      expect { described_class.new(maximum + 1) }.to raise_error(ArgumentError)
    end

    it "accepts a #{described_class} object" do
      described_class.new(described_class.new random_int).to_i.should == random_int
    end
  end

  describe ".byte_string" do
    it "returns the byte string for #{random_int}" do
      subject.byte_string.should == [random_int].pack(pack_char)
    end
  end

  describe ".to_i" do
    it "returns the original integer #{random_int}" do
      subject.to_i.should == random_int
    end
  end
end

shared_examples_for "an alias" do |method|
  let(:value) { 1 }
  describe "alias #{method}" do
    it "should return an object of type #{described_class}" do
      send(method, value).should be_an_instance_of(described_class)
    end
  end
end

describe LegoNXT::UnsignedByte do
  it_should_behave_like "a type"  , 0x00        , 0xFF       , 'C'
  it_should_behave_like "an alias" , :byte
  it_should_behave_like "an alias" , :ubyte
end

describe LegoNXT::SignedByte do
  it_should_behave_like "a type"  , -0x80       , 0x7F       , 'c'
  it_should_behave_like "an alias" , :sbyte
end

describe LegoNXT::UnsignedWord do
  it_should_behave_like "a type"  , 0x0000      , 0xffff     , 'S<'
  it_should_behave_like "an alias" , :word
  it_should_behave_like "an alias" , :uword

  it "should be little endian" do
    described_class.new(1000).byte_string.should == "\xE8\x03"
  end
end

describe LegoNXT::SignedWord do
  it_should_behave_like "a type"  , -0x8000     , 0x7fff     , 's<'
  it_should_behave_like "an alias" , :sword

  it "should be little endian" do
    described_class.new(-1000).byte_string.should == "\x18\xFC"
  end
end

describe LegoNXT::UnsignedLong do
  it_should_behave_like "a type"  , 0x00000000  , 0xffffffff , 'L<'
  it_should_behave_like "an alias" , :long
  it_should_behave_like "an alias" , :ulong

  it "should be little endian" do
    described_class.new(1000).byte_string.should == "\xE8\x03\x00\x00"
  end
end

describe LegoNXT::SignedLong do
  it_should_behave_like "a type"  , -0x80000000 , 0x7fffffff , 'l<'
  it_should_behave_like "an alias" , :slong

  it "should be little endian" do
    described_class.new(-1000).byte_string.should == "\x18\xFC\xFF\xFF"
  end
end

describe :bytestring do
  it "should accept integers" do
    bytestring(0x00, 0x20, 0x30).should == "\x00\x20\x30"
  end

  it "should accept Types" do
    type = LegoNXT::SignedLong.new 1234
    bytestring(type).should == type.byte_string
  end
end
