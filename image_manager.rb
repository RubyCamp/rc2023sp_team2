# 画像オブジェクトを読み込み、キャッシングするためのクラス
class ImageManager
	@@caches = {}

	# 引数pathの画像をロードし、キャッシュする。
	# 既にキャッシング済みの場合はキャッシュからオブジェクトを返す。
	def self.load_image(path)
		return @@caches[path] if @@caches.has_key?(path)
		@@caches[path] = Image.load(path)
		@@caches[path]
	end
end