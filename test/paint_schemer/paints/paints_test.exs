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
    alias PaintSchemer.Paints.PaintType

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def paint_type_fixture(attrs \\ %{}) do
      {:ok, paint_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Paints.create_paint_type()

      paint_type
    end

    test "list_paint_types/0 returns all paint_types" do
      paint_type = paint_type_fixture()
      assert Paints.list_paint_types() == [paint_type]
    end

    test "get_paint_type!/1 returns the paint_type with given id" do
      paint_type = paint_type_fixture()
      assert Paints.get_paint_type!(paint_type.id) == paint_type
    end

    test "create_paint_type/1 with valid data creates a paint_type" do
      assert {:ok, %PaintType{} = paint_type} = Paints.create_paint_type(@valid_attrs)
      assert paint_type.name == "some name"
    end

    test "create_paint_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Paints.create_paint_type(@invalid_attrs)
    end

    test "update_paint_type/2 with valid data updates the paint_type" do
      paint_type = paint_type_fixture()
      assert {:ok, paint_type} = Paints.update_paint_type(paint_type, @update_attrs)
      assert %PaintType{} = paint_type
      assert paint_type.name == "some updated name"
    end

    test "update_paint_type/2 with invalid data returns error changeset" do
      paint_type = paint_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Paints.update_paint_type(paint_type, @invalid_attrs)
      assert paint_type == Paints.get_paint_type!(paint_type.id)
    end

    test "delete_paint_type/1 deletes the paint_type" do
      paint_type = paint_type_fixture()
      assert {:ok, %PaintType{}} = Paints.delete_paint_type(paint_type)
      assert_raise Ecto.NoResultsError, fn -> Paints.get_paint_type!(paint_type.id) end
    end

    test "change_paint_type/1 returns a paint_type changeset" do
      paint_type = paint_type_fixture()
      assert %Ecto.Changeset{} = Paints.change_paint_type(paint_type)
    end
  end

  describe "paints" do
    alias PaintSchemer.Paints.Paint

    @manufacturer_attrs %{name: "some manufacturer"}
    @type_attrs %{name: "some type"}
    @valid_attrs %{color: <<255, 255, 255>>, name: "some name"}
    @update_attrs %{color: <<50, 50, 50>>, name: "some updated name"}
    @invalid_attrs %{color: nil, name: nil}

    def paint_fixture(attrs \\ %{}) do
      {:ok, manufacturer} =
        @manufacturer_attrs
        |> Paints.create_manufacturer()
      {:ok, type} =
        @type_attrs
        |> Paints.create_paint_type()
      {:ok, paint} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{manufacturer_id: manufacturer.id, type_id: type.id})
        |> Paints.create_paint()

      %Paint{ paint | manufacturer: manufacturer, type: type}
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
      {:ok, manufacturer} =
        @manufacturer_attrs
        |> Paints.create_manufacturer()
      {:ok, type} =
        @type_attrs
        |> Paints.create_paint_type()

      assert {:ok, %Paint{} = paint} =
        Map.merge(@valid_attrs, %{manufacturer_id: manufacturer.id, type_id: type.id})
        |> Paints.create_paint()
      assert paint.color == <<255, 255, 255>>
      assert paint.name == "some name"
    end

    test "create_paint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Paints.create_paint(@invalid_attrs)
    end

    test "update_paint/2 with valid data updates the paint" do
      paint = paint_fixture()
      assert {:ok, paint} = Paints.update_paint(paint, @update_attrs)
      assert %Paint{} = paint
      assert paint.color == <<50, 50, 50>>
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



  describe "paint_technique" do
    alias PaintSchemer.Paints.PaintTechnique

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def paint_technique_fixture(attrs \\ %{}) do
      {:ok, paint_technique} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Paints.create_paint_technique()

      paint_technique
    end

    test "list_paint_technique/0 returns all paint_technique" do
      paint_technique = paint_technique_fixture()
      assert Paints.list_paint_technique() == [paint_technique]
    end

    test "get_paint_technique!/1 returns the paint_technique with given id" do
      paint_technique = paint_technique_fixture()
      assert Paints.get_paint_technique!(paint_technique.id) == paint_technique
    end

    test "create_paint_technique/1 with valid data creates a paint_technique" do
      assert {:ok, %PaintTechnique{} = paint_technique} = Paints.create_paint_technique(@valid_attrs)
      assert paint_technique.name == "some name"
    end

    test "create_paint_technique/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Paints.create_paint_technique(@invalid_attrs)
    end

    test "update_paint_technique/2 with valid data updates the paint_technique" do
      paint_technique = paint_technique_fixture()
      assert {:ok, paint_technique} = Paints.update_paint_technique(paint_technique, @update_attrs)
      assert %PaintTechnique{} = paint_technique
      assert paint_technique.name == "some updated name"
    end

    test "update_paint_technique/2 with invalid data returns error changeset" do
      paint_technique = paint_technique_fixture()
      assert {:error, %Ecto.Changeset{}} = Paints.update_paint_technique(paint_technique, @invalid_attrs)
      assert paint_technique == Paints.get_paint_technique!(paint_technique.id)
    end

    test "delete_paint_technique/1 deletes the paint_technique" do
      paint_technique = paint_technique_fixture()
      assert {:ok, %PaintTechnique{}} = Paints.delete_paint_technique(paint_technique)
      assert_raise Ecto.NoResultsError, fn -> Paints.get_paint_technique!(paint_technique.id) end
    end

    test "change_paint_technique/1 returns a paint_technique changeset" do
      paint_technique = paint_technique_fixture()
      assert %Ecto.Changeset{} = Paints.change_paint_technique(paint_technique)
    end
  end
end
