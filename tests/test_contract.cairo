#[cfg(test)]
mod tests {
    use snforge_std::{
        ContractClassTrait, declare, expect_emit, start_prank, stop_prank, test_address,
    };
    use starknet::ContractAddress;
    use test::{ //use tới tên của package tìm trong scarb.toml
        IPizzaFactoryDispatcher, IPizzaFactoryDispatcherTrait,
        PizzaFactory // Thêm dòng này để truy cập event
    };

    #[test]
    pub fn test_make_pizza() {
        let contract_class = declare("PizzaFactory"); // tên modun lấy từ lib.cairo
        let owner = test_address();
        let contract = declare("PizzaFactory").unwrap();
        let contract_address = contract.deploy(@array![owner]).unwrap();
        let dispatcher = IPizzaFactoryDispatcher { contract_address };

        // Thêm nguyên liệu
        dispatcher.increase_pepperoni(1);
        dispatcher.increase_pineapple(1);

        // Giả mạo owner
        start_prank(owner);

        // Kiểm tra event
        expect_emit(
            contract_address,
            PizzaFactory::Event::PizzaEmission(PizzaFactory::PizzaEmission { counter: 1 }),
        );

        dispatcher.make_pizza();
        stop_prank();

        assert_eq!(dispatcher.count_pizza(), 1, 'Pizzacount');
    }
}
