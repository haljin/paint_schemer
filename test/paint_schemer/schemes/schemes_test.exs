defmodule PaintSchemer.SchemesTest do
  use PaintSchemer.DataCase

  alias PaintSchemer.Schemes
  alias PaintSchemer.Paints

  describe "schemes" do
    alias PaintSchemer.Schemes.Scheme

    @valid_attrs %{description: "some description", image_url: "some image_url", title: "some title"}
    @update_attrs %{description: "some updated description", image_url: "some updated image_url", title: "some updated title"}
    @invalid_attrs %{description: nil, image_url: nil, title: nil}

    def scheme_fixture(attrs \\ %{}) do
      {:ok, scheme} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schemes.create_scheme()

      scheme
    end

    test "list_schemes/0 returns all schemes" do
      scheme = scheme_fixture()
      assert Schemes.list_schemes() == [scheme]
    end

    test "get_scheme!/1 returns the scheme with given id" do
      scheme = scheme_fixture()
      assert Schemes.get_scheme!(scheme.id) == scheme
    end

    test "create_scheme/1 with valid data creates a scheme" do
      assert {:ok, %Scheme{} = scheme} = Schemes.create_scheme(@valid_attrs)
      assert scheme.description == "some description"
      assert scheme.image_url == "some image_url"
      assert scheme.title == "some title"
    end

    test "create_scheme/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemes.create_scheme(@invalid_attrs)
    end

    test "update_scheme/2 with valid data updates the scheme" do
      scheme = scheme_fixture()
      assert {:ok, scheme} = Schemes.update_scheme(scheme, @update_attrs)
      assert %Scheme{} = scheme
      assert scheme.description == "some updated description"
      assert scheme.image_url == "some updated image_url"
      assert scheme.title == "some updated title"
    end

    test "update_scheme/2 with invalid data returns error changeset" do
      scheme = scheme_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemes.update_scheme(scheme, @invalid_attrs)
      assert scheme == Schemes.get_scheme!(scheme.id)
    end

    test "delete_scheme/1 deletes the scheme" do
      scheme = scheme_fixture()
      assert {:ok, %Scheme{}} = Schemes.delete_scheme(scheme)
      assert_raise Ecto.NoResultsError, fn -> Schemes.get_scheme!(scheme.id) end
    end

    test "change_scheme/1 returns a scheme changeset" do
      scheme = scheme_fixture()
      assert %Ecto.Changeset{} = Schemes.change_scheme(scheme)
    end
  end

  describe "scheme_section" do
    alias PaintSchemer.Schemes.Section

    @scheme_attrs %{description: "some description", image_url: "some image_url", title: "some title"}
    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{scheme_id: nil}

    def section_fixture(attrs \\ %{}) do
      {:ok, scheme} =
        @scheme_attrs
        |> Schemes.create_scheme()
      {:ok, section} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{scheme_id: scheme.id})
        |> Schemes.create_section()

      section
    end

    test "list_scheme_section/0 returns all scheme_section" do
      section = section_fixture()
      assert Schemes.list_scheme_section() == [section]
    end

    test "get_section!/1 returns the section with given id" do
      section = section_fixture()
      assert Schemes.get_section!(section.id) == section
    end

    test "create_section/1 with valid data creates a section" do
      {:ok, scheme} =
        @scheme_attrs
        |> Schemes.create_scheme()

      assert {:ok, %Section{} = section} =
        Map.merge(@valid_attrs, %{scheme_id: scheme.id})
        |> Schemes.create_section()
      assert %Section{} = section
    end

    test "create_section/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemes.create_section(@invalid_attrs)
    end

    test "update_section/2 with valid data updates the section" do
      section = section_fixture()
      assert {:ok, section} = Schemes.update_section(section, @update_attrs)
      assert %Section{} = section
    end

    test "update_section/2 with invalid data returns error changeset" do
      section = section_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemes.update_section(section, @invalid_attrs)
      assert section == Schemes.get_section!(section.id)
    end

    test "delete_section/1 deletes the section" do
      section = section_fixture()
      assert {:ok, %Section{}} = Schemes.delete_section(section)
      assert_raise Ecto.NoResultsError, fn -> Schemes.get_section!(section.id) end
  end

    test "change_section/1 returns a section changeset" do
      section = section_fixture()
      assert %Ecto.Changeset{} = Schemes.change_section(section)
    end
  end

  describe "scheme_step" do
    alias PaintSchemer.Schemes.Step
    alias PaintSchemer.Schemes
    alias PaintSchemer.Paints

    @paint_technique_attrs %{name: "Some technique"}
    @scheme_attrs %{description: "some description", image_url: "some image_url", title: "some title"}
    @section_attrs %{title: "Some title"}
    @valid_attrs %{ordering: 42}
    @update_attrs %{ordering: 43}
    @invalid_attrs %{ordering: nil}

    def step_fixture(attrs \\ %{}) do
      {:ok, technique} =
        @paint_technique_attrs
        |> Paints.create_paint_technique()
      {:ok, scheme} =
        @scheme_attrs
        |> Schemes.create_scheme()
      {:ok, section} =
        @section_attrs
        |> Enum.into(%{scheme_id: scheme.id})
        |> Schemes.create_section()
      {:ok, step} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{paint_technique_id: technique.id, section_id: section.id})
        |> Schemes.create_step()

      step
    end

    test "list_scheme_step/0 returns all scheme_step" do
      step = step_fixture()
      assert Schemes.list_scheme_step() == [step]
    end

    test "get_step!/1 returns the step with given id" do
      step = step_fixture()
      assert Schemes.get_step!(step.id) == step
    end

    test "create_step/1 with valid data creates a step" do
      {:ok, technique} =
        @paint_technique_attrs
        |> Paints.create_paint_technique()
      {:ok, scheme} =
        @scheme_attrs
        |> Schemes.create_scheme()
      {:ok, section} =
        @section_attrs
        |> Enum.into(%{scheme_id: scheme.id})
        |> Schemes.create_section()


      assert {:ok, %Step{} = step} =
        Map.merge(@valid_attrs, %{paint_technique_id: technique.id, section_id: section.id})
        |> Schemes.create_step()
      assert step.ordering == 42
    end

    test "create_step/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemes.create_step(@invalid_attrs)
    end

    test "update_step/2 with valid data updates the step" do
      step = step_fixture()
      assert {:ok, step} = Schemes.update_step(step, @update_attrs)
      assert %Step{} = step
      assert step.ordering == 43
    end

    test "update_step/2 with invalid data returns error changeset" do
      step = step_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemes.update_step(step, @invalid_attrs)
      assert step == Schemes.get_step!(step.id)
    end

    test "delete_step/1 deletes the step" do
      step = step_fixture()
      assert {:ok, %Step{}} = Schemes.delete_step(step)
      assert_raise Ecto.NoResultsError, fn -> Schemes.get_step!(step.id) end
    end

    test "change_step/1 returns a step changeset" do
      step = step_fixture()
      assert %Ecto.Changeset{} = Schemes.change_step(step)
    end
  end

  describe "scheme_mixes" do
    alias PaintSchemer.Schemes.PaintMix

    @manufacturer_attrs %{name: "some manufacturer"}
    @type_attrs %{name: "some type"}
    @paint_attrs %{color: <<255, 255, 255>>, name: "some paint"}
    @paint_technique_attrs %{name: "Some technique"}
    @scheme_attrs %{description: "some description", image_url: "some image_url", title: "some title"}
    @section_attrs %{title: "Some title"}
    @step_attrs %{ordering: 42}
    @valid_attrs %{ratio: 42}
    @update_attrs %{ratio: 43}
    @invalid_attrs %{ratio: nil}

    def paint_mix_fixture(attrs \\ %{}) do
      {:ok, manufacturer} =
        @manufacturer_attrs
        |> Paints.create_manufacturer()
      {:ok, type} =
        @type_attrs
        |> Paints.create_paint_type()
      {:ok, paint} =
        @paint_attrs
        |> Enum.into(%{manufacturer_id: manufacturer.id, type_id: type.id})
        |> Paints.create_paint()
      {:ok, technique} =
        @paint_technique_attrs
        |> Paints.create_paint_technique()
      {:ok, scheme} =
        @scheme_attrs
        |> Schemes.create_scheme()
      {:ok, section} =
        @section_attrs
        |> Enum.into(%{scheme_id: scheme.id})
        |> Schemes.create_section()
      {:ok, step} =
        @step_attrs
        |> Enum.into(%{section_id: section.id, paint_technique_id: technique.id})
        |> Schemes.create_step()

      {:ok, paint_mix} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{paint_id: paint.id, step_id: step.id})
        |> Schemes.create_paint_mix()

      paint_mix
    end

    test "list_scheme_mixes/0 returns all scheme_mixes" do
      paint_mix = paint_mix_fixture()
      assert Schemes.list_scheme_mixes() == [paint_mix]
    end

    test "get_paint_mix!/1 returns the paint_mix with given id" do
      paint_mix = paint_mix_fixture()
      assert Schemes.get_paint_mix!(paint_mix.id) == paint_mix
    end

    test "create_paint_mix/1 with valid data creates a paint_mix" do
      {:ok, manufacturer} =
        @manufacturer_attrs
        |> Paints.create_manufacturer()
      {:ok, type} =
        @type_attrs
        |> Paints.create_paint_type()
      {:ok, paint} =
        @paint_attrs
        |> Enum.into(%{manufacturer_id: manufacturer.id, type_id: type.id})
        |> Paints.create_paint()
      {:ok, technique} =
        @paint_technique_attrs
        |> Paints.create_paint_technique()
      {:ok, scheme} =
        @scheme_attrs
        |> Schemes.create_scheme()
      {:ok, section} =
        @section_attrs
        |> Enum.into(%{scheme_id: scheme.id})
        |> Schemes.create_section()
      {:ok, step} =
        @step_attrs
        |> Enum.into(%{section_id: section.id, paint_technique_id: technique.id})
        |> Schemes.create_step()

      assert {:ok, %PaintMix{} = paint_mix} =
        Map.merge(@valid_attrs, %{paint_id: paint.id, step_id: step.id})
        |> Schemes.create_paint_mix()
      assert paint_mix.ratio == 42
    end

    test "create_paint_mix/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemes.create_paint_mix(@invalid_attrs)
    end

    test "update_paint_mix/2 with valid data updates the paint_mix" do
      paint_mix = paint_mix_fixture()
      assert {:ok, paint_mix} = Schemes.update_paint_mix(paint_mix, @update_attrs)
      assert %PaintMix{} = paint_mix
      assert paint_mix.ratio == 43
    end

    test "update_paint_mix/2 with invalid data returns error changeset" do
      paint_mix = paint_mix_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemes.update_paint_mix(paint_mix, @invalid_attrs)
      assert paint_mix == Schemes.get_paint_mix!(paint_mix.id)
    end

    test "delete_paint_mix/1 deletes the paint_mix" do
      paint_mix = paint_mix_fixture()
      assert {:ok, %PaintMix{}} = Schemes.delete_paint_mix(paint_mix)
      assert_raise Ecto.NoResultsError, fn -> Schemes.get_paint_mix!(paint_mix.id) end
    end

    test "change_paint_mix/1 returns a paint_mix changeset" do
      paint_mix = paint_mix_fixture()
      assert %Ecto.Changeset{} = Schemes.change_paint_mix(paint_mix)
    end
  end
end
