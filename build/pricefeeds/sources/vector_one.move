module net2dev_addr::vector_one {
    use std::vector;
    use std::debug::print;

    fun vector_basics(): vector<u64> {
        //init vector
        let list = vector::empty<u64>();

        // insert 10
        //list.push_back(10);
        vector::push_back(&mut list, 10); // [10]
        vector::push_back(&mut list, 20); // [10, 20]

        //store at index 2
        vector::insert(&mut list, 2, 30); // [10, 20, 30]
        vector::insert(&mut list, 3, 50); // [10, 20, 30, 50]
        //can override
        vector::insert(&mut list, 2, 20); // [10, 20, 20, 50]

        // swap index
        vector::swap(&mut list, 1 ,0);

        let value = *vector::borrow_mut(&mut list, 2);
        value = value + 10;
        vector::insert(&mut list , 2 ,value); // [20,10,30,20,30,50]

        list.remove(3); // [20,10,30,30,50]

        // return last indef of vector and remove it

        let value = list.pop_back(); //[20,10,30,30]

        print(&value); // should be 50
        list
    }

    fun while_loop_vector(list: vector<u64>): vector<u64>{
        let lenght = list.length();
        let i: u64 = 0;
        while (i < lenght){
            let value = vector::borrow(&list, i);
            print(value);
            i += 1;
        };
        list
    }

    fun read_element(e: u64){
        print(&e)
    }

    fun update_element(e: &mut u64){
        *e += 1;
    }

    fun for_each_vector(list: vector<u64>) {
        list.for_each_mut(|list| update_element(list));
        list.for_each(|list| read_element(list));
    }

    // #[test]
    // fun test_fun(){
    //     let l = vector_basics();
    //     print(&l);

    //     assert!(l.contains(&10) == true); // return a bool if present

    //     let (is_present , _) = l.index_of(&30); // return first instance
    //     print(&is_present);

    //     let list = while_loop_vector(l);
    //     for_each_vector(list);
    // }
}