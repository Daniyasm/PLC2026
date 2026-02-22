with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;     use Ada.Float_Text_IO;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
-- with makes a library available, like Java's import. 
-- use is an additional step that brings the library's contents into scope without 
-- needing to prefix everything — similar to Java's import static

procedure PlayList is
-- Ada's entry point is a named procedure rather than a main method.
-- In Java you'd write public static void main(String[] args), in Haskell main = do

-- The is keyword opens the declaration section where you define types and variables 
--  before the code runs


    type Person is record
        name : Unbounded_String;
    end record;

    procedure Put_Person (p : Person) is
    begin
        Put (To_String (p.name));
    end Put_Person;

   --   type Item is record
   --       name        : Unbounded_String;
   --       performer   : Person;
   --       length_secs : Float;
   --   end record;

    type item_variant_type is (piece, pause);  -- enum

    type Item (item_variant : item_variant_type) is
         record
               length_secs : Float; -- common field for both pieces and pauses
               case item_variant is
                   when piece =>
                       name : Unbounded_String;
                       performer : Person;
                   when pause =>
                       null;  -- no additional fields for a pause
               end case;
         end record;

    procedure Put_Item (i : Item) is
    begin
      case i.item_variant is
         when piece =>
            Put (To_String (i.name));
            Put (" by ");
            Put_Person (i.performer);
            Put (" (");
            Put (i.length_secs, aft => 1, exp => 0);
            Put ("s)");
         when pause =>
            Put ("Pause: ");
            Put (i.length_secs, aft => 1, exp => 0);
            Put ("s");
      end case;
    end Put_Item;
    -- Put_Item is doing the same job as Haskell's show instance and Java's toString() 
    -- formatting an Item for display.
    -- aft => 1 means 1 digit after the decimal point, and exp => 0 suppresses scientific 
    -- notation.

    piece1 : Item (item_variant => piece) :=
       (item_variant => piece,
         name => To_Unbounded_String ("Moonlight Sonata"),
        performer => (name => To_Unbounded_String ("Claudio Arrau")),
        length_secs => 17.0*60.0+26.0
       );

    pause1 : Item (item_variant => pause) :=
      (
       item_variant => PAUSE,
       length_secs => 5.0
      );

begin
    Put_Item (piece1);
    Put_Line ("");
    Put_Item(pause1);
    Put_Line ("");
end PlayList;
