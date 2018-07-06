require "byebug"

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.lenght < 2
    pivot = array.shift()
    l = []
    r = []
    array.each do |el|
      el<pivot ? l.push(el) : r.push(el)
    end
    return self.class.sort1(l) + [pivot] + self.class.sort1(r)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new {|a,b| a <=> b}

    idx = self.partition(array, start, length, &prc)

    leftLength = idx - start
    rightLength = length -idx -1

    self.sort2!(array, start, leftLength, &prc) if idx-start >= 2
    self.sort2!(array, idx+1, rightLength, &prc ) if length - idx >= 2

  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|a,b| a <=> b}
    pivot = array[start]
    partition = start + 1
    ((start+1) ...start+length).each do |idx|
      if prc.call(array[idx], pivot) < 1
        if partition != idx
          temp = array[partition]
          array[partition] = array[idx]
          array[idx] =  temp
        end
        partition += 1
      end
    end
    array[start] = array[partition -1]
    array[partition - 1] = pivot
    return partition - 1
  end
end

p QuickSort.sort2!([9,2,5,3,4,1,7])
