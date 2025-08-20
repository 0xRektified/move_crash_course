module net2dev_addr::Sample5{
    const ADD: u64 = 0;
    const SUB: u64 = 1;
    const MUL: u64 = 2;
    const DIV: u64 = 3;
    const MOD: u64 = 4;

    fun arythmetic_operations(a: u64, b: u64, operator: u64): u64{
        if (operator == ADD){
            return a+b
        } else if (operator == SUB){
            return a-b
        } else if (operator == MUL){
            return a*b
        } else if (operator == DIV){
            return a/b
        } else{
            return a%b
        }
    }

    const HIGHER: u64 = 0;
    const LOWER: u64 = 1;
    const HIGHER_EQ: u64 = 2;
    const LOWER_EQ: u64 = 3;

    fun equality_operations(a: u64, b: u64, operator: u64): bool{
        if (operator == HIGHER){
            return a > b
        } else if (operator == LOWER){
            return a < b
        } else if (operator == HIGHER_EQ){
            return a >= b
        } else {
            return a <= b
        }
    }

    #[test_only]
    use std::debug::print;
    #[test]
    fun test_arythmetic(){
        let result = arythmetic_operations(2 ,1 , ADD);
        print(&result);
        result = arythmetic_operations(2 ,1 , SUB);
        print(&result);
        result = arythmetic_operations(2 ,1 , MUL);
        print(&result);
        result = arythmetic_operations(2 ,1 , DIV);
        print(&result);
        result = arythmetic_operations(2 ,1 , MOD);
        print(&result);
    }

    #[test]
    fun test_equality(){
        let result = equality_operations(2 ,1 , HIGHER);
        print(&result);
        result = equality_operations(2 ,1 , LOWER);
        print(&result);
        result = equality_operations(2 , 2, HIGHER_EQ);
        print(&result); 
        result = equality_operations(2 ,2 , LOWER_EQ);
        print(&result);
    }
}