module net2dev_addr::MapsDemo {
    use std::simple_map::{SimpleMap, Self};
    use std::string::{String, utf8};

    fun remove_from_map(my_map: SimpleMap<u64,String>, key: u64):SimpleMap<u64,String>{
        simple_map::remove(&mut my_map, &key);
        my_map
    }

    fun check_map_len(my_map: SimpleMap<u64,String>):u64{
        simple_map::length(&mut my_map)
    }

    fun create_map(): SimpleMap<u64,String>{
        let my_map:SimpleMap<u64,String> = simple_map::create();
        simple_map::add(&mut my_map, 1, utf8(b"UAE"));
        simple_map::add(&mut my_map, 2, utf8(b"RUS"));
        simple_map::add(&mut my_map, 3, utf8(b"COL"));
        simple_map::add(&mut my_map, 4, utf8(b"US"));
        return my_map
    }

    // #[test_only]
    // use std::debug::print;

    // #[test]
    // fun test_fun(){
    //     let my_map = create_map();
    //     my_map = remove_from_map(my_map, 2);
    //     let length = check_map_len((my_map));
    //     print(&length);
    //     let country = simple_map::borrow(
    //             &mut my_map,
    //             &3
    //         );
    //     print(country);
    // }
}