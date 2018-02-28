defmodule PaintSchemer.PaintsTest do
  use PaintSchemer.DataCase

  alias PaintSchemer.Paints

  describe "paint_manufacturers" do
    alias PaintSchemer.Paints.Manufacturer

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def manufacturer_fixture(attrs \\ %{}) do
      {:ok, manufacturer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Paints.create_manufacturer()

      manufacturer
    end

    test "list_paint_manufacturers/0 returns all paint_manufacturers" do
      manufacturer = manufacturer_fixture()
      assert Paints.list_paint_manufacturers() == [manufacturer]
    end

    test "get_manufacturer!/1 returns the manufacturer with given id" do
      manufacturer = manufacturer_fixture()
      assert Paints.get_manufacturer!(manufacturer.id) == manufacturer
    end

    test "create_manufacturer/1 with valid data creates a manufacturer" do
      assert {:ok, %Manufacturer{} = manufacturer} = Paints.create_manufacturer(@valid_attrs)
      assert manufacturer.name == "some name"
    end

    test "create_manufacturer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Paints.create_manufacturer(@invalid_attrs)
    end

    test "update_manufacturer/2 with valid data updates the manufacturer" do
      manufacturer = manufacturer_fixture()
      assert {:ok, manufacturer} = Paints.update_manufacturer(manufacturer, @update_attrs)
      assert %Manufacturer{} = manufacturer
      assert manufacturer.name == "some updated name"
    end

    test "update_manufacturer/2 with invalid data returns error changeset" do
      manufacturer = manufacturer_fixture()
      assert {:error, %Ecto.Changeset{}} = Paints.update_manufacturer(manufacturer, @invalid_attrs)
      assert manufacturer == Paints.get_manufacturer!(manufacturer.id)
    end

    test "delete_manufacturer/1 deletes the manufacturer" do
      manufacturer = manufacturer_fixture()
      assert {:ok, %Manufacturer{}} = Paints.delete_manufacturer(manufacturer)
      assert_raise Ecto.NoResultsError, fn -> Paints.get_manufacturer!(manufacturer.id) end
    end

    test "change_manufacturer/1 returns a manufacturer changeset" do
      manufacturer = manufacturer_fixture()
      assert %Ecto.Changeset{} = Paints.change_manufacturer(manufacturer)
    end
  end

  describe "paint_types" do
    alias PaintSchemer.Paints.Type

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def type_fixture(attrs \\ %{}) do
      {:ok, type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Paints.create_type()

      type
    end

    test "list_paint_types/0 returns all paint_types" do
      type = type_fixture()
      assert Paints.list_paint_types() == [type]
    end

    test "get_type!/1 returns the type with given id" do
      type = type_fixture()
      assert Paints.get_type!(type.id) == type
    end

    test "create_type/1 with valid data creates a type" do
      assert {:ok, %Type{} = type} = Paints.create_type(@valid_attrs)
      assert type.name == "some name"
    end

    test "create_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Paints.create_type(@invalid_attrs)
    end

    test "update_type/2 with valid data updates the type" do
      type = type_fixture()
      assert {:ok, type} = Paints.update_type(type, @update_attrs)
      assert %Type{} = type
      assert type.name == "some updated name"
    end

    test "update_type/2 with invalid data returns error changeset" do
      type = type_fixture()
      assert {:error, %Ecto.Changeset{}} = Paints.update_type(type, @invalid_attrs)
      assert type == Paints.get_type!(type.id)
    end

    test "delete_type/1 deletes the type" do
      type = type_fixture()
      assert {:ok, %Type{}} = Paints.delete_type(type)
      assert_raise Ecto.NoResultsError, fn -> Paints.get_type!(type.id) end
    end

    test "change_type/1 returns a type changeset" do
      type = type_fixture()
      assert %Ecto.Changeset{} = Paints.change_type(type)
    end
  end

  describe "paints" do
    alias PaintSchemer.Paints.Paint

    @valid_attrs %{color: "some color", name: "some name"}
    @update_attrs %{color: "some updated color", name: "some updated name"}
    @invalid_attrs %{color: nil, name: nil}

    def paint_fixture(attrs \\ %{}) do
      {:ok, paint} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Paints.create_paint()

      paint
    end

    test "list_paints/0 returns all paints" do
      paint = paint_fixture()
      assert Paints.list_paints() == [paint]
    end

    test "get_paint!/1 returns the paint with given id" do
      paint = paint_fixture()
      assert Paints.get_paint!(paint.id) == paint
    end

    test "create_paint/1 with valid data creates a paint" do
      assert {:ok, %Paint{} = paint} = Paints.create_paint(@valid_attrs)
      assert paint.color == "some color"
      assert paint.name == "some name"
    end

    test "create_paint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Paints.create_paint(@invalid_attrs)
    end

    test "update_paint/2 with valid data updates the paint" do
      paint = paint_fixture()
      assert {:ok, paint} = Paints.update_paint(paint, @update_attrs)
      assert %Paint{} = paint
      assert paint.color == "some updated color"
      assert paint.name == "some updated name"
    end

    test "update_paint/2 with invalid data returns error changeset" do
      paint = paint_fixture()
      assert {:error, %Ecto.Changeset{}} = Paints.update_paint(paint, @invalid_attrs)
      assert paint == Paints.get_paint!(paint.id)
    end

    test "delete_paint/1 deletes the paint" do
      paint = paint_fixture()
      assert {:ok, %Paint{}} = Paints.delete_paint(paint)
      assert_raise Ecto.NoResultsError, fn -> Paints.get_paint!(paint.id) end
    end

    test "change_paint/1 returns a paint changeset" do
      paint = paint_fixture()
      assert %Ecto.Changeset{} = Paints.change_paint(paint)
    end
  end
end
