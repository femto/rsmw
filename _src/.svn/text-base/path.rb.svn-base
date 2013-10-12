#currently we don't need to convert from / to \ or add path prefix
def convertPathInternal(source)
  return source
end
def convertPath(source,pack=nil)
  if pack.nil? 
    return convertPathInternal(source)
  end
  if source.index("gfx/packs/") == 0
    trailingdir = source[9,source.length];
    s = pack + trailingdir
    #if File.exist?(s)
    #return s
    #
    #return s
    return "gfx/packs/Classic" + trailingdir
  end
  
  if source.index("sfx/packs/") == 0
    trailingdir = source[9,source.length];
    s = pack + trailingdir
    #if File.exist?(s)
    #return s
    #
    #return s
    return "sfx/packs/Classic" + trailingdir
  end
end