defmodule PaintSchemer.SchemesTest do
  use PaintSchemer.DataCase

  alias PaintSchemer.Schemes

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

  describe "scheme_sections" do
    alias PaintSchemer.Schemes.Sections

    @valid_attrs %{ordering: 42}
    @update_attrs %{ordering: 43}
    @invalid_attrs %{ordering: nil}

    def sections_fixture(attrs \\ %{}) do
      {:ok, sections} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schemes.create_sections()

      sections
    end

    test "list_scheme_sections/0 returns all scheme_sections" do
      sections = sections_fixture()
      assert Schemes.list_scheme_sections() == [sections]
    end

    test "get_sections!/1 returns the sections with given id" do
      sections = sections_fixture()
      assert Schemes.get_sections!(sections.id) == sections
    end

    test "create_sections/1 with valid data creates a sections" do
      assert {:ok, %Sections{} = sections} = Schemes.create_sections(@valid_attrs)
      assert sections.ordering == 42
    end

    test "create_sections/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemes.create_sections(@invalid_attrs)
    end

    test "update_sections/2 with valid data updates the sections" do
      sections = sections_fixture()
      assert {:ok, sections} = Schemes.update_sections(sections, @update_attrs)
      assert %Sections{} = sections
      assert sections.ordering == 43
    end

    test "update_sections/2 with invalid data returns error changeset" do
      sections = sections_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemes.update_sections(sections, @invalid_attrs)
      assert sections == Schemes.get_sections!(sections.id)
    end

    test "delete_sections/1 deletes the sections" do
      sections = sections_fixture()
      assert {:ok, %Sections{}} = Schemes.delete_sections(sections)
      assert_raise Ecto.NoResultsError, fn -> Schemes.get_sections!(sections.id) end
    end

    test "change_sections/1 returns a sections changeset" do
      sections = sections_fixture()
      assert %Ecto.Changeset{} = Schemes.change_sections(sections)
    end
  end

  describe "scheme_steps" do
    alias PaintSchemer.Schemes.Steps

    @valid_attrs %{ordering: 42}
    @update_attrs %{ordering: 43}
    @invalid_attrs %{ordering: nil}

    def steps_fixture(attrs \\ %{}) do
      {:ok, steps} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schemes.create_steps()

      steps
    end

    test "list_scheme_steps/0 returns all scheme_steps" do
      steps = steps_fixture()
      assert Schemes.list_scheme_steps() == [steps]
    end

    test "get_steps!/1 returns the steps with given id" do
      steps = steps_fixture()
      assert Schemes.get_steps!(steps.id) == steps
    end

    test "create_steps/1 with valid data creates a steps" do
      assert {:ok, %Steps{} = steps} = Schemes.create_steps(@valid_attrs)
      assert steps.ordering == 42
    end

    test "create_steps/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schemes.create_steps(@invalid_attrs)
    end

    test "update_steps/2 with valid data updates the steps" do
      steps = steps_fixture()
      assert {:ok, steps} = Schemes.update_steps(steps, @update_attrs)
      assert %Steps{} = steps
      assert steps.ordering == 43
    end

    test "update_steps/2 with invalid data returns error changeset" do
      steps = steps_fixture()
      assert {:error, %Ecto.Changeset{}} = Schemes.update_steps(steps, @invalid_attrs)
      assert steps == Schemes.get_steps!(steps.id)
    end

    test "delete_steps/1 deletes the steps" do
      steps = steps_fixture()
      assert {:ok, %Steps{}} = Schemes.delete_steps(steps)
      assert_raise Ecto.NoResultsError, fn -> Schemes.get_steps!(steps.id) end
    end

    test "change_steps/1 returns a steps changeset" do
      steps = steps_fixture()
      assert %Ecto.Changeset{} = Schemes.change_steps(steps)
    end
  end

  describe "scheme_mixes" do
    alias PaintSchemer.Schemes.PaintMix

    @valid_attrs %{ratio: 42}
    @update_attrs %{ratio: 43}
    @invalid_attrs %{ratio: nil}

    def paint_mix_fixture(attrs \\ %{}) do
      {:ok, paint_mix} =
        attrs
        |> Enum.into(@valid_attrs)
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
      assert {:ok, %PaintMix{} = paint_mix} = Schemes.create_paint_mix(@valid_attrs)
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
