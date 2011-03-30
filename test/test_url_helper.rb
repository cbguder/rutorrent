require 'rutorrent'
require 'test/unit'

class TestURLHelper < Test::Unit::TestCase
  def path_for(args)
    args[:token] = 'TOKEN' if Hash === args
    RUTorrent::Helpers::URLHelper::path_for(args)
  end

  def test_token_html
    assert_equal '/gui/token.html', path_for('/token.html')
  end

  def test_list
    assert_equal '/gui/?token=TOKEN&list=1', path_for(:list => 1)
  end

  def test_list_cid
    assert_equal '/gui/?token=TOKEN&list=1&cid=CACHEID', path_for(:list => 1, :cid => 'CACHEID')
  end

  def test_action
    assert_equal "/gui/?token=TOKEN&action=getsettings", path_for(:action => 'getsettings')
  end

  def test_action_s
    assert_equal '/gui/?token=TOKEN&action=add-url&s=URL', path_for(:action => 'add-url', :s => 'URL')
  end

  def test_action_s_v
    assert_equal '/gui/?token=TOKEN&action=setsetting&s=SETTING&v=VALUE', path_for(:action => 'setsetting', :s => 'SETTING', :v => 'VALUE')
  end

  def test_action_hash
    actions = %q{getfiles getprops start stop pause unpause forcestart recheck
      remove removedata queuebottom queuedown queuetop queueup}

    actions.each do |action|
      assert_equal "/gui/?token=TOKEN&action=#{action}&hash=HASH", path_for(:action => action, :hash => 'HASH')
    end
  end

  def test_action_hash_s_v
    assert_equal '/gui/?token=TOKEN&action=setprops&hash=HASH&s=PROPERTY&v=VALUE', path_for(:action => 'setprops', :hash => 'HASH', :s=> 'PROPERTY', :v => 'VALUE')
  end

  def test_action_hash_p_f
    assert_equal '/gui/?token=TOKEN&action=setprio&hash=HASH&p=0&f=0', path_for(:action => 'setprio', :hash => 'HASH', :p=> 0, :f => 0)
  end
end
