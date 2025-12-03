from abc import ABC, abstractmethod
from typing import List

# 1. ABSTRACT CLASS
class LibraryItem(ABC):
    def __init__(self, title: str, item_id: int, cost: float):
        self.title = title
        self.item_id = item_id
        
        # Private property (indicated by double underscore)
        self.__replacement_cost = cost
        
        # Protected property (convention only in Python)
        self._is_checked_out = False

    # Abstract method
    @abstractmethod
    def get_loan_duration(self) -> int:
        pass

    # Public method
    def check_out(self):
        if self._is_checked_out:
            print(f"Error: '{self.title}' is already checked out.")
        else:
            self._is_checked_out = True
            print(f"Success: You checked out '{self.title}'.")

    def return_item(self):
        self._is_checked_out = False
        print(f"Returned: '{self.title}'.")

    def get_cost(self):
        return self.__replacement_cost
    
    def get_details(self) -> str:
        return f"ID: {self.item_id} | Title: {self.title}"


# 2. INHERITANCE
class Book(LibraryItem):
    def __init__(self, title: str, item_id: int, cost: float, author: str):
        super().__init__(title, item_id, cost)
        self.author = author

    # Implementing the abstract method
    def get_loan_duration(self) -> int:
        return 21

    def get_details(self) -> str:
        base_details = super().get_details()
        return f"{base_details} | Type: Book | Author: {self.author}"


# 2. INHERITANCE
class DVD(LibraryItem):
    def __init__(self, title: str, item_id: int, cost: float, duration_min: int):
        super().__init__(title, item_id, cost)
        self.duration_min = duration_min

    def get_loan_duration(self) -> int:
        return 7

    def get_details(self) -> str:
        base_details = super().get_details()
        return f"{base_details} | Type: DVD | Runtime: {self.duration_min} mins"


# 3. CLASS WITH REFERENCES AND LISTS
class LibraryMember:
    def __init__(self, name: str):
        self.name = name
        
        self.borrowed_items: List[LibraryItem] = []
        
        self.__wallet_balance = 0.0

    def pay_fees(self, amount: float, specific_reason: str = None):
        """
        Demonstrates overloading logic. 
        Can be called with just an amount, or an amount and a reason.
        """
        if specific_reason:
            print(f"Processing payment of ${amount} for: {specific_reason}")
        else:
            print(f"Processing generic account payment of ${amount}")
        
        self.__wallet_balance += amount
        print(f"New Balance: ${self.__wallet_balance}")

    def borrow(self, item: LibraryItem):
        if not item._is_checked_out:
            item.check_out()
            self.borrowed_items.append(item)
            days = item.get_loan_duration()
            print(f"Due back in {days} days.")
        else:
            print(f"Cannot borrow '{item.title}', it is unavailable.")

    def show_inventory(self):
        print(f"\n--- {self.name}'s Current Items ---")
        if not self.borrowed_items:
            print("No items borrowed.")
        for item in self.borrowed_items:
            print(item.get_details())
        print("----------------------------------\n")


if __name__ == "__main__":
    print("=== INITIALIZING LIBRARY SYSTEM ===\n")

    book1 = Book("The Great Gatsby", 101, 15.99, "F. Scott Fitzgerald")
    book2 = Book("1984", 102, 12.50, "George Orwell")
    dvd1 = DVD("Inception", 201, 25.00, 148)

    member = LibraryMember("Alice Smith")

    print(f"Public Title: {book1.title}")
    print(f"Private Cost (via getter): ${book1.get_cost()}\n")

    member.borrow(book1)
    member.borrow(dvd1)
    
    member.borrow(book1) 

    member.show_inventory()

    print(f"Loan period for Book: {book1.get_loan_duration()} days")
    print(f"Loan period for DVD: {dvd1.get_loan_duration()} days\n")

    print("--- Payment System (Overloading) ---")
    member.pay_fees(10.00)                        
    member.pay_fees(5.50, "Late return of '1984'") 