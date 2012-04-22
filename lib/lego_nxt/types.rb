module LegoNXT
  # A superclass for all the types.
  #
  # This is not general useful.
  #
  # @visibility private
  class Type
    # @param [Fixnum] integer
    def initialize integer
      @integer = integer.to_i
      if @integer < minimum || @integer > maximum
        raise ArgumentError.new("#{self.class} can only be between #{minimum} and #{maximum}: got #@integer")
      end
    end

    # Get a packed byte string for the integer.
    #
    # @return [String] A packed byte string.
    def byte_string
      [@integer].pack(pack_char)
    end

    # Returns the original integer value.
    #
    # @return [Fixnum]
    def to_i
      @integer
    end

    # The character(s) used to pack/unpack the integer.
    #
    # See the documentation for `Array::pack` for more info.
    #
    # @return [String] the single pack/unpack character.
    def pack_char
      raise NotImplemented.new(".pack_char needs to be overriden in a subclass.")
    end

    # The minimum value that can be held.
    #
    # @return [Fixnum]
    def minimum
      raise NotImplemented.new(".minimum needs to be overriden in a subclass.")
    end

    # The maximum value that can be held.
    #
    # @return [Fixnum]
    def maximum
      raise NotImplemented.new(".maximum needs to be overriden in a subclass.")
    end
  end

  # An unsigned byte.
  class UnsignedByte < Type
    # {include:Type#pack_char}
    # @return [String]
    def pack_char;   'C'; end
    # {include:Type#minimum}
    # @return [Fixnum]
    def minimum;    0x00; end
    # {include:Type#maximum}
    # @return [Fixnum]
    def maximum;    0xff; end
  end

  # A signed byte.
  class SignedByte < Type
    # {include:Type#pack_char}
    # @return [String]
    def pack_char;   'c'; end
    # {include:Type#minimum}
    # @return [Fixnum]
    def minimum;   -0x80; end
    # {include:Type#maximum}
    # @return [Fixnum]
    def maximum;    0x7f; end
  end

  # An unsigned word (two bytes).
  class UnsignedWord < Type
    # {include:Type#pack_char}
    # @return [String]
    def pack_char;    'S'; end
    # {include:Type#minimum}
    # @return [Fixnum]
    def minimum;   0x0000; end
    # {include:Type#maximum}
    # @return [Fixnum]
    def maximum;   0xffff; end
  end

  # A signed word (two bytes).
  class SignedWord < Type
    # {include:Type#pack_char}
    # @return [String]
    def pack_char;     's'; end
    # {include:Type#minimum}
    # @return [Fixnum]
    def minimum;   -0x8000; end
    # {include:Type#maximum}
    # @return [Fixnum]
    def maximum;    0x7fff; end
  end

  # An unsigned long (four bytes).
  class UnsignedLong < Type
    # {include:Type#pack_char}
    # @return [String]
    def pack_char;         'l'; end
    # {include:Type#minimum}
    # @return [Fixnum]
    def minimum;    0x00000000; end
    # {include:Type#maximum}
    # @return [Fixnum]
    def maximum;    0xffffffff; end
  end

  # A signed long (four bytes).
  class SignedLong < Type
    # {include:Type#pack_char}
    # @return [String]
    def pack_char;         'l'; end
    # {include:Type#minimum}
    # @return [Fixnum]
    def minimum;   -0x80000000; end
    # {include:Type#maximum}
    # @return [Fixnum]
    def maximum;    0x7fffffff; end
  end
end

# Helper method for creating an {LegoNXT::UnsignedByte}
#
# @param [Fixnum] i The integer value for the byte.
def byte i
  ubyte i
end

# Helper method for creating an {LegoNXT::UnsignedByte}
#
# @param [Fixnum] i The integer value for the byte.
def ubyte i
  LegoNXT::UnsignedByte.new i
end

# Helper method for creating an {LegoNXT::SignedByte}
#
# @param [Fixnum] i The integer value for the byte.
def sbyte i
  LegoNXT::SignedByte.new i
end

# Helper method for creating an {LegoNXT::UnsignedWord}
#
# @param [Fixnum] i The integer value for the word.
def word i
  uword i
end

# Helper method for creating an {LegoNXT::UnsignedWord}
#
# @param [Fixnum] i The integer value for the word.
def uword i
  LegoNXT::UnsignedWord.new i
end

# Helper method for creating an {LegoNXT::SignedWord}
#
# @param [Fixnum] i The integer value for the word.
def sword i
  LegoNXT::SignedWord.new i
end

# Helper method for creating an {LegoNXT::UnsignedLong}
#
# @param [Fixnum] i The integer value for the long.
def long i
  ulong i
end

# Helper method for creating an {LegoNXT::UnsignedLong}
#
# @param [Fixnum] i The integer value for the long.
def ulong i
  LegoNXT::UnsignedLong.new i
end

# Helper method for creating an {LegoNXT::SignedLong}
#
# @param [Fixnum] i The integer value for the long.
def slong i
  LegoNXT::SignedLong.new i
end

# Takes a sequence of `Integer`s or {LegoNXT::Type}s.
#
# @param [Integer,LegoNXT::Type] bytes One (or more) bytes.
# @return [String] The packed bytestring.
def bytestring *bytes
  bytes.map do |byte|
    if not byte.respond_to? :byte_string
      byte = LegoNXT::UnsignedByte.new(byte)
    end
    byte.byte_string
  end.join('')
end
