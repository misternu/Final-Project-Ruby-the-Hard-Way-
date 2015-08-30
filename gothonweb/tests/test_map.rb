require "gothonweb/map.rb"
require "test/unit"

class TestMap < Test::Unit::TestCase

	def test_room()
		gold = Map::Room.new("GoldMap::Room",
								"""This room has gold in it you can grab. There's a
						door to the north.""")
		assert_equal(gold.name, "GoldMap::Room")
		assert_equal(gold.paths, {})
	end

	def test_room_paths()
		center = Map::Room.new("Center", "Test room in the center.")
		north = Map::Room.new("North", "Test room in the north.")
		south = Map::Room.new("South", "Test room in the south.")

		center.add_paths({'north'=> north, 'south'=> south})
		assert_equal(center.go('north'), north)
		assert_equal(center.go('south'), south)

	end

	def test_map()
		start = Map::Room.new("Start", "You can go west and down a hole.")
		west = Map::Room.new("Trees", "There are trees here, you can go east.")
		down = Map::Room.new("Dungeon", "It's dark down here, you can go up.")

		start.add_paths({'west'=> west, 'down'=> down})
		west.add_paths({'east'=> start})
		down.add_paths({'up'=> start})

		assert_equal(start.go('west'), west)
		assert_equal(start.go('west').go('east'), start)
		assert_equal(start.go('down').go('up'), start)
	end

	def test_gothon_game_map()

		# Central Corridor
		assert_equal(Map::CENTRAL_CORRIDOR, Map::START)
		assert_equal(Map::SHOOT_DEATH, Map::START.go('shoot!'))
		assert_equal(Map::DODGE_DEATH, Map::START.go('dodge!'))
		assert_equal(Map::LASER_WEAPON_ARMORY, Map::START.go('tell a joke'))

		# # Laser Weapon Armory
		# assert_equal(Map::THE_BRIDGE, Map::LASER_WEAPON_ARMORY.go('132'))
		# assert_equal(Map::ARMORY_DEATH, Map::LASER_WEAPON_ARMORY.go('*'))

		# The Bridge
		assert_equal(Map::THROW_DEATH, Map::THE_BRIDGE.go('throw the bomb'))
		assert_equal(Map::ESCAPE_POD, Map::THE_BRIDGE.go('slowly place the bomb'))

		# # Escape Pod Room
		# assert_equal(Map::THE_END_WINNER, Map::ESCAPE_POD.go('2'))
		# assert_equal(Map::THE_END_LOSER, Map::ESCAPE_POD.go('*'))

	end

	def test_session_loading()
		session = {}

		room = Map::load_room(session)
		assert_equal(nil, room)

		Map::save_room(session, Map::START)
		room = Map::load_room(session)
		assert_equal(Map::START, room)

		room = room.go('tell a joke')
		assert_equal(Map::LASER_WEAPON_ARMORY, room)

		Map::save_room(session, room)
		assert_equal(Map::LASER_WEAPON_ARMORY, room)
	end
end