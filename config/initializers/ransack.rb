# ブロック作成
Ransack.configure do |config|

    # 実際のビューで使われるpredicateの名前を決める。
    # 要は述語をカスタムするとこ
    config.add_predicate 'lteq_end_of_day',
                        # arel_predicate: '〇〇' 　→〇〇内でカスタムの元にするpredicateを指定。
                        arel_predicate: 'lteq',
                        # vが検索されて受け取る値になる。
                        # { |v| v.end_of_day }このブロック内で自分で自由にフォーマットを変えることが可能
                        # ここではend_of_dayメソッドを実行している。
                        # end_of_dayメソッドはその日の最後の時点のタイムスタンプを返す
                        formatter: proc { |v| v.end_of_day }
                        # バリデーション設定もできる。
                        # validator: proc { |v| v.present? }
                        # stringやintegerなどのオブジェクトタイプを指定できる。
                        # type: :string
                        # 大文字、小文字の区別を設定できる。デフォルトはfault。
                        # case_insensitive: :true
end

# _eq:等しい
# _not_eq:等しくない
# _It:より小さい（等しいもの含む）
# _gt:より大きい
# _cont:部分一致（内容を含む）
