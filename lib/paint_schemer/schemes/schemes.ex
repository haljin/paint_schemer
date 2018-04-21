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
    Repo.all(Scheme)
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
  def get_scheme!(id), do: Repo.get!(Scheme, id)

  @doc """
  Creates a scheme.

  ## Examples

      iex> create_scheme(%{field: value})
      {:ok, %Scheme{}}

      iex> create_scheme(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scheme(attrs \\ %{}) do
    %Scheme{}
    |> Scheme.changeset(attrs)
    |> Repo.insert()
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

  alias PaintSchemer.Schemes.Sections

  @doc """
  Returns the list of scheme_sections.

  ## Examples

      iex> list_scheme_sections()
      [%Sections{}, ...]

  """
  def list_scheme_sections do
    Repo.all(Sections)
  end

  @doc """
  Gets a single sections.

  Raises `Ecto.NoResultsError` if the Sections does not exist.

  ## Examples

      iex> get_sections!(123)
      %Sections{}

      iex> get_sections!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sections!(id), do: Repo.get!(Sections, id)

  @doc """
  Creates a sections.

  ## Examples

      iex> create_sections(%{field: value})
      {:ok, %Sections{}}

      iex> create_sections(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sections(attrs \\ %{}) do
    %Sections{}
    |> Sections.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sections.

  ## Examples

      iex> update_sections(sections, %{field: new_value})
      {:ok, %Sections{}}

      iex> update_sections(sections, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sections(%Sections{} = sections, attrs) do
    sections
    |> Sections.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Sections.

  ## Examples

      iex> delete_sections(sections)
      {:ok, %Sections{}}

      iex> delete_sections(sections)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sections(%Sections{} = sections) do
    Repo.delete(sections)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sections changes.

  ## Examples

      iex> change_sections(sections)
      %Ecto.Changeset{source: %Sections{}}

  """
  def change_sections(%Sections{} = sections) do
    Sections.changeset(sections, %{})
  end

  alias PaintSchemer.Schemes.Steps

  @doc """
  Returns the list of scheme_steps.

  ## Examples

      iex> list_scheme_steps()
      [%Steps{}, ...]

  """
  def list_scheme_steps do
    Repo.all(Steps)
  end

  @doc """
  Gets a single steps.

  Raises `Ecto.NoResultsError` if the Steps does not exist.

  ## Examples

      iex> get_steps!(123)
      %Steps{}

      iex> get_steps!(456)
      ** (Ecto.NoResultsError)

  """
  def get_steps!(id), do: Repo.get!(Steps, id)

  @doc """
  Creates a steps.

  ## Examples

      iex> create_steps(%{field: value})
      {:ok, %Steps{}}

      iex> create_steps(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_steps(attrs \\ %{}) do
    %Steps{}
    |> Steps.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a steps.

  ## Examples

      iex> update_steps(steps, %{field: new_value})
      {:ok, %Steps{}}

      iex> update_steps(steps, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_steps(%Steps{} = steps, attrs) do
    steps
    |> Steps.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Steps.

  ## Examples

      iex> delete_steps(steps)
      {:ok, %Steps{}}

      iex> delete_steps(steps)
      {:error, %Ecto.Changeset{}}

  """
  def delete_steps(%Steps{} = steps) do
    Repo.delete(steps)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking steps changes.

  ## Examples

      iex> change_steps(steps)
      %Ecto.Changeset{source: %Steps{}}

  """
  def change_steps(%Steps{} = steps) do
    Steps.changeset(steps, %{})
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
