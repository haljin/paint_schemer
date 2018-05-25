defmodule PaintSchemer.Schemes do
  @moduledoc """
  The Schemes context.
  """

  import Ecto.Query, warn: false
  alias PaintSchemer.Repo

  alias PaintSchemer.Schemes.Scheme

  @doc """
  Returns the list of schemes.

  ## Examples

      iex> list_schemes()
      [%Scheme{}, ...]

  """
  def list_schemes do
    Repo.all(scheme_associative_expr())
    # Repo.all(Scheme)
    # |> Enum.map(&preload_scheme/1)
  end

  @doc """
  Gets a single scheme.

  Raises `Ecto.NoResultsError` if the Scheme does not exist.

  ## Examples

      iex> get_scheme!(123)
      %Scheme{}

      iex> get_scheme!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scheme!(id),
    do:
      Scheme
      |> Repo.get!(id)
      |> preload_scheme

  @doc """
  Creates a scheme.

  ## Examples

      iex> create_scheme(%{field: value})
      {:ok, %Scheme{}}

      iex> create_scheme(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scheme(attrs \\ %{}) do
    with {:ok, data} <- %Scheme{} |> Scheme.changeset(attrs) |> Repo.insert() do
      data
      |> preload_scheme
      |> (fn d -> {:ok, d} end).()
    else
      error -> error
    end
  end

  @doc """
  Updates a scheme.

  ## Examples

      iex> update_scheme(scheme, %{field: new_value})
      {:ok, %Scheme{}}

      iex> update_scheme(scheme, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scheme(%Scheme{} = scheme, attrs) do
    scheme
    |> Scheme.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Scheme.

  ## Examples

      iex> delete_scheme(scheme)
      {:ok, %Scheme{}}

      iex> delete_scheme(scheme)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scheme(%Scheme{} = scheme) do
    Repo.delete(scheme)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scheme changes.

  ## Examples

      iex> change_scheme(scheme)
      %Ecto.Changeset{source: %Scheme{}}

  """
  def change_scheme(%Scheme{} = scheme) do
    Scheme.changeset(scheme, %{})
  end

  # This call instead results in a lot of quesries one for each table
  defp preload_scheme(%Scheme{} = scheme) do
    Repo.preload(scheme, sections: [steps: [:paint_technique, paints: [paint: [:manufacturer, :type]]]])
  end

  # This call results in a single SELECT query with a lot of joins
  defp scheme_associative_expr do
    from scheme in Scheme,
      left_join: section in assoc(scheme, :sections),
      left_join: step in assoc(section, :steps),
      left_join: pt in assoc(step, :paint_technique),
      left_join: mixes in assoc(step, :paints),
      left_join: paints in assoc(mixes, :paint),
      left_join: m in assoc(paints, :manufacturer),
      left_join: t in assoc(paints, :type),
      preload: [sections: {section, steps: {step, [paint_technique: pt, paints: {mixes, paint: {paints, [type: t, manufacturer: m]}}]}}]
  end

  alias PaintSchemer.Schemes.Section

  @doc """
  Returns the list of scheme_section.

  ## Examples

      iex> list_scheme_section()
      [%Section{}, ...]

  """
  def list_scheme_section do
    Repo.all(Section)
  end

  @doc """
  Gets a single section.

  Raises `Ecto.NoResultsError` if the Section does not exist.

  ## Examples

      iex> get_section!(123)
      %Section{}

      iex> get_section!(456)
      ** (Ecto.NoResultsError)

  """
  def get_section!(id), do: Repo.get!(Section, id)

  @doc """
  Creates a section.

  ## Examples

      iex> create_section(%{field: value})
      {:ok, %Section{}}

      iex> create_section(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_section(attrs \\ %{}) do
    %Section{}
    |> Section.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a section.

  ## Examples

      iex> update_section(section, %{field: new_value})
      {:ok, %Section{}}

      iex> update_section(section, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_section(%Section{} = section, attrs) do
    section
    |> Section.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Section.

  ## Examples

      iex> delete_section(section)
      {:ok, %Section{}}

      iex> delete_section(section)
      {:error, %Ecto.Changeset{}}

  """
  def delete_section(%Section{} = section) do
    Repo.delete(section)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking section changes.

  ## Examples

      iex> change_section(section)
      %Ecto.Changeset{source: %Section{}}

  """
  def change_section(%Section{} = section) do
    Section.changeset(section, %{})
  end

  alias PaintSchemer.Schemes.Step

  @doc """
  Returns the list of scheme_step.

  ## Examples

      iex> list_scheme_step()
      [%Step{}, ...]

  """
  def list_scheme_step do
    Repo.all(Step)
  end

  @doc """
  Gets a single step.

  Raises `Ecto.NoResultsError` if the Step does not exist.

  ## Examples

      iex> get_step!(123)
      %Step{}

      iex> get_step!(456)
      ** (Ecto.NoResultsError)

  """
  def get_step!(id), do: Repo.get!(Step, id)

  @doc """
  Creates a step.

  ## Examples

      iex> create_step(%{field: value})
      {:ok, %Step{}}

      iex> create_step(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_step(attrs \\ %{}) do
    %Step{}
    |> Step.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a step.

  ## Examples

      iex> update_step(step, %{field: new_value})
      {:ok, %Step{}}

      iex> update_step(step, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_step(%Step{} = step, attrs) do
    step
    |> Step.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Step.

  ## Examples

      iex> delete_step(step)
      {:ok, %Step{}}

      iex> delete_step(step)
      {:error, %Ecto.Changeset{}}

  """
  def delete_step(%Step{} = step) do
    Repo.delete(step)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking step changes.

  ## Examples

      iex> change_step(step)
      %Ecto.Changeset{source: %Step{}}

  """
  def change_step(%Step{} = step) do
    Step.changeset(step, %{})
  end

  alias PaintSchemer.Schemes.PaintMix

  @doc """
  Returns the list of scheme_mixes.

  ## Examples

      iex> list_scheme_mixes()
      [%PaintMix{}, ...]

  """
  def list_scheme_mixes do
    Repo.all(PaintMix)
  end

  @doc """
  Gets a single paint_mix.

  Raises `Ecto.NoResultsError` if the Paint mix does not exist.

  ## Examples

      iex> get_paint_mix!(123)
      %PaintMix{}

      iex> get_paint_mix!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paint_mix!(id), do: Repo.get!(PaintMix, id)

  @doc """
  Creates a paint_mix.

  ## Examples

      iex> create_paint_mix(%{field: value})
      {:ok, %PaintMix{}}

      iex> create_paint_mix(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paint_mix(attrs \\ %{}) do
    %PaintMix{}
    |> PaintMix.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a paint_mix.

  ## Examples

      iex> update_paint_mix(paint_mix, %{field: new_value})
      {:ok, %PaintMix{}}

      iex> update_paint_mix(paint_mix, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paint_mix(%PaintMix{} = paint_mix, attrs) do
    paint_mix
    |> PaintMix.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PaintMix.

  ## Examples

      iex> delete_paint_mix(paint_mix)
      {:ok, %PaintMix{}}

      iex> delete_paint_mix(paint_mix)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paint_mix(%PaintMix{} = paint_mix) do
    Repo.delete(paint_mix)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paint_mix changes.

  ## Examples

      iex> change_paint_mix(paint_mix)
      %Ecto.Changeset{source: %PaintMix{}}

  """
  def change_paint_mix(%PaintMix{} = paint_mix) do
    PaintMix.changeset(paint_mix, %{})
  end
end
