class UnionFind
  def initialize
    @ids = []
  end

  def <<(n)
    @ids[n] = n
  end

  def connected?(id1,id2)
    @ids[id1] == @ids[id2]
  end
  
  def union(id1,id2)
    id_1, id_2 = @ids[id1], @ids[id2]
    @ids.map! {|i| (i == id_1) ? id_2 : i }
  end

  def clusters
    @ids.compact.uniq.count
  end
end
